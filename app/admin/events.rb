ActiveAdmin.register Event do
  menu parent: ["Organizations"]
  permit_params :name, :image_url, :start_time, :end_time, :location, :organization_id 

  index do
    selectable_column
    column :name
    column :start_time
    column :end_time
    column :location
    column :organization do |e|
      Organization.find(e.organization_id).name
    end
    actions
  end

  filter :name
  filter :organization

  form do |f|
    f.inputs do
      f.input :organization_id, as: :select, collection: Organization.all
      f.input :name
      f.input :image_url
      f.input :start_time, as: :datetime_picker
      f.input :end_time, as: :datetime_picker
      f.input :location
    end
    f.actions
  end

  show title: :name do |event|
    attributes_table do
      row :name
      row :start_time
      row :end_time
      row :location
    end
  
    # This is the part that sucks.
    div class: 'panel' do
      h3 'Rounds'
      div class: 'attributes_table' do
        table do
          tr do
            th 'Order'
            th 'Round Type'
          end
          event.event_rounds.order(:order).each do |round|
            tr do
              td link_to round.order, admin_event_round_path(round)
              td round.round_type
            end
          end
        end
      end
    end
  end

end
