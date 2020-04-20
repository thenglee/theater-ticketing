require "rails_helper"

describe ShoppingCartsController do

  describe "update" do
    let(:shop_user) { create(:user) }
    let(:performance) { create(:performance, event: create(:event)) }
    let(:action) { instance_spy(AddsToCart) }

    before(:example) do
      allow(@controller).to receive(:current_user).and_return(shop_user)
      allow(Performance).to receive(:find).with("2").and_return(performance)
      allow(AddsToCart).to receive(:new).with(
        performance: performance, count: "1", user: shop_user).and_return(action)
    end

    it "calls add to cart on success" do
      allow(action).to receive(:success).and_return(true)

      patch :update, params: { performance_id: "2", ticket_count: "1" }

      expect(action).to have_received(:run)
      expect(@controller).to redirect_to(shopping_cart_path)
    end

    it "redirects back to the event if unsuccessful" do
      allow(action).to receive(:success).and_return(false)

      patch :update, params: { performance_id: "2", ticket_count: "1" }

      expect(action).to have_received(:run)
      expect(@controller).to redirect_to(performance.event)
    end
  end
end
