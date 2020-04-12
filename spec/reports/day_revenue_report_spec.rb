require "rails_helper"

RSpec.describe DayRevenueReport, type: :model do

  let(:user) { create(:user) }
  let!(:really_old_payment) { create(:payment, created_at: 1.month.ago, price_cents: 4500, discount_cents: 0, user: user) }
  let!(:really_old_payment_2) { create(:payment, created_at: 1.month.ago, price_cents: 1500, discount_cents: 0, user: user) }
  let!(:old_payment) { create(:payment, created_at: 2.days.ago, price_cents: 3500, discount_cents: 0, user: user) }
  let!(:yesterday_payment) { create(:payment, created_at: 1.day.ago, price_cents: 2500, discount_cents: 0, user: user) }
  let!(:now_payment) { create(:payment, created_at: 1.second.ago, price_cents: 1500, discount_cents: 0, user: user) }

  before(:example) do
    BuildDayRevenueJob.perform_now
  end

  it "generates the expected report" do
    enum = DayRevenueReport.to_csv_enumerator
    expect(enum.next).to eq("Day,Price,Discounts,Ticket count\n")
    expect(enum.next).to eq("#{1.month.ago.to_date},60.00,0.00,0\n")
    expect(enum.next).to eq("#{2.days.ago.to_date},35.00,0.00,0\n")
    expect(enum.next).to eq("#{1.day.ago.to_date},25.00,0.00,0\n")
    expect(enum.next).to eq("#{Date.current},15.00,0.00,0\n")
  end
end
