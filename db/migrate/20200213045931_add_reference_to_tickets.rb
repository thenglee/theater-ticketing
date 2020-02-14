class AddReferenceToTickets < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :reference, :string
  end
end
