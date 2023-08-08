ActiveAdmin.register Contest do
  permit_params :name, :image_url, :no_of_practice_attempts, :no_of_contest_attempts, :max_points_per_attempt, :location 

  index do
    selectable_column
    column :organization do |c|
      c.organization.name
    end
    column :name
    column :no_of_practice_attempts
    column :no_of_contest_attempts
    column :max_points_per_attempt
    column :location
    actions
  end

  filter :organization
  filter :name

  form do |f|
    f.inputs do
      f.input :organization_id, as: :select, collection: Organization.all
      f.input :name
      f.input :image_url
      f.input :no_of_practice_attempts, as: :number
      f.input :no_of_contest_attempts, as: :number
      f.input :max_points_per_attempt, as: :number
      f.input :location
    end
    f.actions
  end

end
