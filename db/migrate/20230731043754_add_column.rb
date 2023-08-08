class AddColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :contest_group_teams, :event_round_id, :integer
  end
end
