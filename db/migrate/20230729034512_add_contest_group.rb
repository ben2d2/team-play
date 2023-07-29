class AddContestGroup < ActiveRecord::Migration[5.2]
  def change
    create_table :contest_group do |t|
      t.string :contest_id
      t.string :image_url
      t.string :name

      t.timestamps
    end

    create_table :contest_group_team do |t|
      t.string :team_id
      t.string :contest_group_id
      t.integer :points

      t.timestamps
    end
  end
end
