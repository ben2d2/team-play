class AddColumnToContestGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :contest_groups, :event_round_id, :integer
  end
end
