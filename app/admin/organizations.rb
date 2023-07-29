ActiveAdmin.register Organization do
  permit_params :name, :email, :phone, :address, :city, :state, :zip_code, :image_url

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :phone
    column :address do |o|
      "#{o.address} #{o.city}, #{o.state} #{o.zip_code}"
    end
    actions
  end

  filter :name
  filter :city
  filter :state

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :phone
      f.input :address
      f.input :city
      f.input :state
      f.input :zip_code
      f.input :image_url
    end
    f.actions
  end

end
