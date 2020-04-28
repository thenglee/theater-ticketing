class MoreAffiliateFields < ActiveRecord::Migration[6.0]
  def change
    change_table :affiliates do |t|
      t.boolean :stripe_charges_enabled, default: false
      t.boolean :stripe_payouts_enabled, default: false
      t.string :stripe_disabled_reason
      t.datetime :stripe_validation_due_by
    end
  end
end
