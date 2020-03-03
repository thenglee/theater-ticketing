class AddStripeCustomerToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :stripe_id, :string
  end
end
