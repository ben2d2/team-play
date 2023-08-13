class AddColumnTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :event_id, :integer
  end
end
