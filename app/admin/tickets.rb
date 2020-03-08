ActiveAdmin.register Ticket do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :user_id, :performance_id, :status, :access, :price_cents, :price_currency, :payment_reference
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :performance_id, :status, :access, :price_cents, :price_currency, :payment_reference]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
