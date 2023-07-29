class AddEvent < ActiveRecord::Migration[5.2]
  def change
    create_table :event do |t|
      t.string :name
      t.string :image_url
      t.string :location
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end

    create_table :organization_event do |t|
      t.string :organization_id
      t.string :event_id

      t.timestamps
    end
  end
end
