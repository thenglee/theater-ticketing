class RenameReferenceToPaymentReferenceInTickets < ActiveRecord::Migration[6.0]
  def change
    rename_column :tickets, :reference, :payment_reference
  end
end
