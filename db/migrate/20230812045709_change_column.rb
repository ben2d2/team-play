class ChangeColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :event_team_contests, :round, :event_round_id
  end
end
