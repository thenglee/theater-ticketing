ActiveAdmin.register Subscription do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :user_id, :plan_id, :start_date, :end_date, :status, :payment_method, :remote_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :plan_id, :start_date, :end_date, :status, :payment_method, :remote_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
