ActiveAdmin.register Organization do
  permit_params :name, :email, :phone, :address, :city, :state, :zip_code, :image_url

  index do
    selectable_column
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

  show title: :name do |organization|
    attributes_table do
      row :name
      row :email
      row :phone
      row :address do |o|
        "#{o.address} #{o.city}, #{o.state} #{o.zip_code}"
      end
    end
  
    # This is the part that sucks.
    div class: 'panel' do
      h3 'Events'
      div class: 'attributes_table' do
        table do
          tr do
            th 'Name'
            th 'Start'
            th 'End'
            th 'Location'
          end
          organization.events.each do |event|
            tr do
              td link_to event.name, admin_event_path(event)
              td event.start_time
              td event.end_time
              td event.location
            end
          end
        end
      end
    end
  end

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
