ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :password, :password_confirmation, :team_id
  #
  # or
  #
  show do
    attributes_table do
      row :name
      row :email
      row :phone
      row :teams do |u|
        u.user_teams.map(&:team).map(&:name)
      end
    end
    active_admin_comments
  end

  permit_params do
    permitted = [:name, :email, :phone, :password, :password_confirmation]
    if params[:user] && params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    permitted
  end

  form do |f|
    inputs do
      input :name
      input :email
      input :phone
      input :password
      input :password_confirmation
    end
    actions
  end
  
end
