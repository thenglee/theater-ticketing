ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :email, :password, :password_confirmation, :cellphone_number
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :stripe_id, :role]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :cellphone_number
    end
    actions
  end

  controller do
    def update
      @user = User.find(params[:id])
      if params[:user][:password].blank?
        @user.update_without_password(permitted_params[:user])
      else
        @user.update_attributes(permitted_params[:user])
      end

      return if @user.admin? && params[:user][:cellphone_number].blank?

      authy = Authy::API.register_user(
        email: @user.email,
        cellphone: params[:user][:cellphone_number],
        country_code: "65")
      @user.update(authy_id: authy.id) if authy
    end
  end

  action_item :simulate_user, only: :show do
    link_to("Simulate User", user_simulation_path(id_to_simulate: resource.id),
            method: :post, class: "action-edit",
            data: { confirm: "Do you want to simulate this user?" })
  end

end
