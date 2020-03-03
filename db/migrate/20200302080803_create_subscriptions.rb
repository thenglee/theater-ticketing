class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :plan, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.integer :status
      t.string :payment_method
      t.string :remote_id

      t.timestamps
    end
  end
end
