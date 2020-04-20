require "rails_helper"

RSpec.describe AddsPlanToCart do
  fixtures :all

  let(:user) { create(:user) }
  let(:plan) { plans(:vip_monthly) }
  let(:action) { AddsPlanToCart.new(user: user, plan: plan) }

  describe "happy path adding plans" do
    it "adds a ticket to cart" do
      action.run
      expect(action).to be_a_success
      expect(action.result).to have_attributes(
        user: user, plan: plan, start_date: Date.current.to_date,
        end_date: Date.current.to_date + 1.month)
      expect(action.result).to be_waiting
    end
  end
end
