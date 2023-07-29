class AddContest < ActiveRecord::Migration[5.2]
  def change
    create_table :contest do |t|
      t.string :name
      t.string :image_url
      t.string :location

      t.timestamps
    end

    create_table :event_round_contest do |t|
      t.string :event_round_id
      t.string :contest_id

      t.timestamps
    end
  end
end
