class AddUserTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :user_teams do |t|
      t.string :user_id
      t.string :team_id

      t.timestamps
    end

    remove_column :users, :team_id
  end
end
