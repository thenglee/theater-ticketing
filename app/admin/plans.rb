ActiveAdmin.register Plan do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :remote_id, :name, :price_cents, :price_currency, :interval, :interval_count, :tickets_allowed, :ticket_category, :status, :description
  #
  # or
  #
  # permit_params do
  #   permitted = [:remote_id, :name, :price_cents, :price_currency, :interval, :interval_count, :tickets_allowed, :ticket_category, :status, :description]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
