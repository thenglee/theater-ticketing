ActiveAdmin.register Payment do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :price, :discount, :status, :payment_method
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :price_cents, :price_currency, :status, :reference, :payment_method, :response_id, :full_response]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  filter :reference
  filter :price
  filter :status
  filter :payment_method
  filter :created_at

  index do
    selectable_column
    id_column
    column :reference
    column :user
    column :price
    column :discount
    column :discount_code do |payment|
      if payment.discount_code
        link_to payment.discount_code&.code, admin_discount_code_path(payment.discount_code)
      end
    end
    column :status
    column :payment_method
    column :created_at
    actions
  end

  show do
    attributes_table do
    row :reference
    row :price
    row :discount
    row :discount_code do |payment|
      if payment.discount_code
        link_to payment.discount_code&.code, admin_discount_code_path(payment.discount_code)
      end
    end
    row :status
    row :payment_method
    row :user
    row :created_at
    row :response_id
    row :full_response
    end
    active_admin_comments
  end

  form do |f|
    f.input :price
    f.input :discount
    f.input :status
    f.input :payment_method
    f.actions
  end

  action_item :refund, only: :show do
    link_to("Refund Payment",
            refunds_path(params: { id: payment.id, type: Payment} ),
            method: "POST",
            class: "button",
            data: { confirm: "Are you sure you want to refund this payment?" } )
  end
end
