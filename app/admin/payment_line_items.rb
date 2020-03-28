ActiveAdmin.register PaymentLineItem do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :payment_id, :buyable_type, :buyable_id, :price_cents, :price_currency, :original_line_item_id, :administrator_id, :refund_status
  #
  # or
  #
  # permit_params do
  #   permitted = [:payment_id, :buyable_type, :buyable_id, :price_cents, :price_currency, :original_line_item_id, :administrator_id, :refund_status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  filter :buyable_type
  filter :price
  filter :refund_status

  index do
    selectable_column
    id_column
    column :payment
    column :buyable
    column :price
    column :refund_status
    column :created_at
  end

  show do
    attributes_table do
      row :payment
      row :buyable
      row :price
      row :refund_status
      row :original_line_item
      row :administrator
      row :created_at
    end
  end

  action_item :refund, only: :show do
    link_to("Refund Payment Line Item",
            refunds_path(params: { id: payment_line_item.id, type: PaymentLineItem} ),
            method: "POST",
            class: "button",
            data: { confirm: "Are you sure you want to refund this payment line item?" } )
  end
end
