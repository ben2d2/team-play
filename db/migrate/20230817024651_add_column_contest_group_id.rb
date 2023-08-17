class AddColumnContestGroupId < ActiveRecord::Migration[5.2]
  def change
    add_column :event_team_contests, :contest_group_id, :integer, null: true
  end
end
