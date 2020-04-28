require "rails_helper"

RSpec.describe AddsAffiliateToCart do
  let(:user) { create(:user) }
  let(:affiliate_user) { create(:user, email: "test@ex.com") }
  let!(:affiliate) { create(:affiliate, tag: "tag", user: affiliate_user) }

  it "adds tag to cart if cart exists" do
    workflow = AddsAffiliateToCart.new(tag: "tag", user: user)
    workflow.run
    expect(ShoppingCart.for(user: user).affiliate).to eq(affiliate)
  end

  it "does not add tag to cart if the tag does not exist" do
    workflow = AddsAffiliateToCart.new(tag: "banana", user: user)
    workflow.run
    expect(ShoppingCart.for(user: user).affiliate).to be_nil
  end

  it "does not add tag to cart if the tag is nil" do
    workflow = AddsAffiliateToCart.new(tag: nil, user: user)
    workflow.run
    expect(ShoppingCart.for(user: user).affiliate).to be_nil
  end

  it "correctly adds tag if the case is wrong" do
    workflow = AddsAffiliateToCart.new(tag: "TAG", user: user)
    workflow.run
    expect(ShoppingCart.for(user: user).affiliate).to eq(affiliate)
  end

  it "does nothing if there is no current user" do
    workflow = AddsAffiliateToCart.new(tag: "tag", user: nil)
    workflow.run
    expect(ShoppingCart.for(user: user).affiliate).to be_nil
  end

  it "does nothing if the affiliate belongs to the user" do
    affiliate.update(user: user)
    workflow = AddsAffiliateToCart.new(tag: "tag", user: user)
    workflow.run
    expect(ShoppingCart.for(user: user).affiliate).to be_nil
  end
end
