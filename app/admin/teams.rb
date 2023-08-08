ActiveAdmin.register Team do
  permit_params :name, :image_url, user_ids: []

  index do
    selectable_column
    column :name
    column :image do |team|
      image_tag team.image_url, width: "16px" 
    end
    column :users do |t|
      t.user_teams.map(&:user).map(&:name)
    end
    actions
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
      f.input :image_url
      # f.input :users, :as => :select, :input_html => {:multiple => true}
    end
    f.actions
  end

end
