ActiveAdmin.register Contest do
  permit_params :name, :image_url, :no_of_practice_attempts, :no_od_contest_attempts, :max_points_per_attempt, :location 

  index do
    selectable_column
    id_column
    column :name
    column :no_of_practice_attempts
    column :no_of_contest_attempts
    column :max_points_per_attempt
    column :location
    actions
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
      f.input :image_url
      f.input :no_of_practice_attempts
      f.input :no_of_contest_attempts
      f.input :max_points_per_attempt
      f.input :location
    end
    f.actions
  end

end
