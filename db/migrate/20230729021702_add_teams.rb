class AddTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :team do |t|
      t.string :name
      t.string :image_url

      t.timestamps
    end

    create_table :user_team do |t|
      t.string :user_id
      t.string :team_id

      t.timestamps
    end
  end
end
