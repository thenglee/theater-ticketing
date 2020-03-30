class RenameDiscountCodeMaxUses < ActiveRecord::Migration[6.0]
  def change
    rename_column :discount_codes, :max_users, :max_uses
  end
end
