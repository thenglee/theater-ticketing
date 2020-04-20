class AddPartialPricesToPayment < ActiveRecord::Migration[6.0]
  def change
    change_table :payments do |t|
      t.json :partials
    end
  end
end
