require "rails_helper"

RSpec.describe StripeAccount, :vcr do

  describe "updating" do
    let(:affiliate_user) { create(:user) }
    let(:affiliate_workflow) { AddsAffiliateAccount.new(user: affiliate_user) }
    let(:account) { affiliate_workflow.account }
    let(:values) { { business_profile: { mcc: 5734, name: "Hello", product_description: "Awesomes software"  } } }

     it "updates the account from a hash" do
       affiliate_workflow.run
       account.update(values)
       expect(account.account.business_profile.mcc).to eq("5734")
       expect(account.account.business_profile.name).to eq("Hello")
       expect(account.account.business_profile.product_description).to eq("Awesomes software")
     end
  end
end
