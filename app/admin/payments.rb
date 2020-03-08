ActiveAdmin.register Payment do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :user_id, :price_cents, :price_currency, :status, :reference, :payment_method, :response_id, :full_response
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :price_cents, :price_currency, :status, :reference, :payment_method, :response_id, :full_response]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
