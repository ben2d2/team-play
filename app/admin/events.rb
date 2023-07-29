ActiveAdmin.register Event do
  permit_params :name, :image_url, :start_time, :end_time, :location 

  index do
    selectable_column
    id_column
    column :name
    column :start_time
    column :end_time
    column :location
    actions
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
      f.input :image_url
      f.input :start_time
      f.input :end_time
      f.input :location
    end
    f.actions
  end

end
