require "rails_helper"

describe PreparesCartForStripe, :vcr, :aggrefate_failures do

  let(:performance) { create(:performance, event: create(:event)) }
  let(:ticket_1) { create(:ticket, status: "waiting", price: Money.new(1500), performance: performance, payment_reference: "reference") }
  let(:ticket_2) { create(:ticket, status: "waiting", price: Money.new(1500), performance: performance, payment_reference: "reference") }
  let(:ticket_3) { create(:ticket, status: "unsold", price: Money.new(1500), performance: performance, payment_reference: "reference") }
  let(:user) { create(:user) }
  let(:discount_code) { nil }
  let(:discount_code_string) { nil }

  let(:attributes) { { user_id: user.id, price_cents: 3000,
                       reference: a_truthy_value, status: "created", payment_method: "stripe",
                       discount_code_id: nil, discount: Money.zero } }

  let(:workflow) { PreparesCartForStripe.new(user: user, purchase_amount_cents: 3000, stripe_token: token, expected_ticket_ids: "#{ticket_1.id} #{ticket_2.id}", payment_reference: "reference", discount_code_string: discount_code_string) }

  before(:example) do
    [ticket_1, ticket_2].each { |t| t.place_in_cart_for(user) }
  end

  describe "successful credit card purchase", :vcr do

    let(:token) { StripeToken.new(credit_card_number: "4242424242424242", expiration_month: "12", expiration_year: Time.zone.now.year + 1, cvc: "123") }

    it "updates the ticket status" do
      workflow.run
      expect(Ticket.find(ticket_1.id)).to be_purchased
      expect(Ticket.find(ticket_2.id)).to be_purchased
      expect(Ticket.find(ticket_3.id)).not_to be_purchased
      expect(workflow.success).to be_truthy
      expect(workflow.payment_attributes).to match(attributes)
      expect(workflow.payment.payment_line_items.size).to eq(2)
    end

    context "with discount code" do
      let(:workflow) { PreparesCartForStripe.new(user: user, purchase_amount_cents: 2250, stripe_token: token, expected_ticket_ids: "#{ticket_1.id} #{ticket_2.id}", payment_reference: "reference", discount_code_string: discount_code_string) }
      let(:discount_code_string) { "CODE" }
      let!(:discount_code) { create(:discount_code, percentage: 25, code: discount_code_string, minimum_amount: 0, maximum_discount: 0) }

      it "creates a transaction object" do
        workflow.run
        expect(workflow.payment).to have_attributes(
          user_id: user.id, price_cents: 2250, discount_cents: 750,
          reference: a_truthy_value, payment_method: "stripe")
        expect(workflow.payment.payment_line_items.size).to eq(2)
      end
    end
  end

  describe "pre-purchase fails" do
    let(:token) { instance_spy(StripeToken) }

    describe "expected price" do
      let(:workflow) { PreparesCartForStripe.new(user: user, purchase_amount_cents: 2500, stripe_token: token, expected_ticket_ids: "#{ticket_1.id} #{ticket_2.id}") }

      it "does not trigger payment if expected price is incorrect" do
        expect { workflow.run }.to raise_error(ChargeSetupValidityException)
        expect(workflow).not_to be_pre_purchase_valid
        expect(Ticket.find(ticket_1.id)).to be_waiting
        expect(Ticket.find(ticket_2.id)).to be_waiting
        expect(Ticket.find(ticket_3.id)).to be_unsold
        expect(workflow.success).to be_falsy
        expect(workflow.payment).to be_nil
      end
    end

    describe "expected tickets" do
      let(:workflow) { PreparesCartForStripe.new(user: user, purchase_amount_cents: 3000, stripe_token: token, expected_ticket_ids: "#{ticket_1.id} #{ticket_2.id}") }

      it "does not trigger payment if expected tickets are incorrect" do
        expect { workflow.run }.to raise_error(ChargeSetupValidityException)
        expect(workflow).not_to be_pre_purchase_valid
        expect(Ticket.find(ticket_1.id)).to be_waiting
        expect(Ticket.find(ticket_2.id)).to be_waiting
        expect(Ticket.find(ticket_3.id)).to be_unsold
        expect(workflow.success).to be_falsy
        expect(workflow.payment).to be_nil
      end
    end

    # describe "database failure" do
    #   it "does not trigger payment if the database fails" do
    #     expect(StripeCharge).to receive(:new).never
    #     allow(Payment).to receive(:create!).and_raise(ActiveRecord::RecordInvalid)
    #     expect { workflow.run }.to raise_error(ActiveRecord::ActiveRecordError)
    #   end
    # end
  end
end
