class CreateEventTeamContests < ActiveRecord::Migration[5.2]
  def change
    create_table :event_team_contests do |t|
      t.integer :event_id
      t.integer :team_id
      t.integer :contest_id
      t.integer :round
      t.boolean :is_group_round
      t.integer :score

      t.timestamps
    end
  end
end
