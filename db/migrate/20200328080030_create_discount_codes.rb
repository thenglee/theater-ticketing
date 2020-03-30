class CreateDiscountCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :discount_codes do |t|
      t.string :code
      t.integer :percentage
      t.text :description
      t.monetize :minimum_amount
      t.monetize :maximum_discount
      t.integer :max_users

      t.timestamps
    end

    change_table :payments do |t|
      t.references :discount_code
      t.monetize :discount
    end
  end
end
