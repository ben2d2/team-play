ActiveAdmin.register Team do
  permit_params :name, :image_url

  index do
    selectable_column
    id_column
    column :name
    actions
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
      f.input :image_url
    end
    f.actions
  end

end
