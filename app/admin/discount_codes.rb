ActiveAdmin.register DiscountCode do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :code, :percentage, :description, :minimum_amount_cents, :minimum_amount_currency, :maximum_discount_cents, :maximum_discount_currency, :max_users
  #
  # or
  #
  # permit_params do
  #   permitted = [:code, :percentage, :description, :minimum_amount_cents, :minimum_amount_currency, :maximum_discount_cents, :maximum_discount_currency, :max_users]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  filter :percentage
  filter :minimum_amount
  filter :maximum_discount

  index do
    selectable_column
    id_column
    column :code
    column :percentage
    column :minimum_amount
    column :maximum_discount
    column :max_uses
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :code
      row :percentage
      row :minimum_amount
      row :maximum_discount
      row :max_uses
      row :created_at
      row :updated_at
    end
  end
end
