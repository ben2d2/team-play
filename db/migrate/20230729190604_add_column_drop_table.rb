class AddColumnDropTable < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :team_id, :integer
    drop_table :user_teams
  end
end
