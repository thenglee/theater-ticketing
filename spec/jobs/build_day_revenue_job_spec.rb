require "rails_helper"

RSpec.describe BuildDayRevenueJob, type: :job do

  let(:user) { create(:user) }
  let!(:really_old_payment) { create(:payment, created_at: 1.month.ago, price_cents: 4500, discount_cents: 0, user: user) }
  let!(:really_old_payment_2) { create(:payment, created_at: 1.month.ago, price_cents: 1500, discount_cents: 0, user: user) }
  let!(:old_payment) { create(:payment, created_at: 2.days.ago, price_cents: 3500, discount_cents: 0, user: user) }
  let!(:yesterday_payment) { create(:payment, created_at: 1.day.ago, price_cents: 2500, discount_cents: 0, user: user) }
  let!(:now_payment) { create(:payment, created_at: 1.second.ago, price_cents: 1500, discount_cents: 0, user: user) }

  it "runs the report" do
    BuildDayRevenueJob.perform_now
    expect(DayRevenue.count).to eq(2)
    expect(DayRevenue.find_by(day: 1.month.ago).price_cents).to eq(6000)
    expect(DayRevenue.find_by(day: 2.days.ago).price_cents).to eq(3500)
    expect(DayRevenue.find_by(day: 1.day.ago)).to be_nil
    expect(DayRevenue.find_by(day: Date.current)).to be_nil
  end

  it "runs the report twice" do
    BuildDayRevenueJob.perform_now
    BuildDayRevenueJob.perform_now
    expect(DayRevenue.count).to eq(2)
    expect(DayRevenue.find_by(day: 1.month.ago).price_cents).to eq(6000)
  end

  context "it calculates tickets" do
    let!(:ticket) { create(:ticket, performance: create(:performance, event: create(:event))) }
    let!(:payment_line_item) { create(:payment_line_item, payment: really_old_payment, price_cents: 4500,
                                      buyable: ticket, created_at: 1.month.ago) }

    it "adds ticket count" do
      BuildDayRevenueJob.perform_now
      expect(DayRevenue.find_by(day: 1.month.ago).ticket_count).to eq(1)
    end
  end
end
