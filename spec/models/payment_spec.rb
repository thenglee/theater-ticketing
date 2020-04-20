require 'rails_helper'

RSpec.describe Payment, type: :model do

  describe "generate_reference" do

    before(:example) do
      allow(SecureRandom).to receive(:hex).and_return("first", "second")
    end

    it "generates a reference" do
      expect(Payment.generate_reference).to eq("first")
    end

    it "avoids duplicates" do
      create(:payment, reference: "first", user: create(:user), price_cents: 1000)
      expect(Payment.generate_reference).to eq("second")
    end
  end

  describe "copy for refund" do
    let(:user) { create(:user) }
    let(:administrator) { create(:user, email: "admin@mail.com") }
    let(:ticket) { create(:ticket, performance: create(:performance, event: create(:event))) }
    let(:payment) { create(:payment, user: user, price_cents: 3000,
                            reference: Payment.generate_reference,
                            payment_method: "stripe") }
    let!(:payment_line_item) { create(:payment_line_item, payment: payment,
                                     buyable: ticket, price_cents: 1500,
                                     refund_status: "no_refund") }

    it "creates a refund copy" do
      refund_payment = payment.generate_refund_payment(
        amount_cents: 3000, admin: administrator)
      refund_payment.save!
      expect(refund_payment).to have_attributes(
        user_id: user.id, price_cents: -3000,
        reference: a_truthy_value, payment_method: "stripe",
        administrator_id: administrator.id, original_payment_id: payment.id)
      expect(refund_payment).to be_refund_pending
      expect(payment.refunds).to eq([refund_payment])
      line_item = refund_payment.payment_line_items.first
      expect(line_item).to have_attributes(
        payment_id: refund_payment.id, buyable: ticket,
        price_cents: -1500, refund_status: "refund_pending",
        original_line_item_id: payment_line_item.id)
      expect(line_item.original_payment).to eq(payment)
    end
  end

  describe "maximum_available_refund" do
    let(:user) { create(:user) }
    let(:ticket_1) { create(:ticket, performance: create(:performance, event: create(:event))) }
    let(:ticket_2) { create(:ticket, performance: create(:performance, event: create(:event))) }
    let(:payment) { create(:payment, user: user, price_cents: 3000,
                            reference: Payment.generate_reference,
                            payment_method: "stripe") }
    let!(:payment_line_item_1) { create(:payment_line_item, payment: payment,
                                     buyable: ticket_1, price_cents: 1500,
                                     refund_status: "no_refund") }
    let!(:payment_line_item_2) { create(:payment_line_item, payment: payment,
                                     buyable: ticket_2, price_cents: 1500,
                                     refund_status: "no_refund") }

    it "calculates the maximum available refund when there are no refunds" do
      expect(payment.maximum_available_refund).to eq(3000)
      expect(payment.can_refund?(1500)).to be_truthy
    end

    it "calculates when there is a refund" do
      payment.generate_refund_payment(amount_cents: 3000, admin: user)
      expect(payment.maximum_available_refund).to eq(0)
    end

    it "calculates when there is a partial refund" do
      payment_line_item_1.generate_refund_payment(amount_cents: 1500, admin: user)
      expect(payment.maximum_available_refund).to eq(1500)
    end
  end
end
