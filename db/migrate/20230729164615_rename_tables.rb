class RenameTables < ActiveRecord::Migration[5.2]
  def change
    rename_table :team, :teams
    rename_table :user_team, :user_teams
    rename_table :organization, :organizations
    rename_table :organization_event, :organization_events
    rename_table :event_round, :event_rounds
    rename_table :event_round_contest, :event_round_contests
    rename_table :contest, :contests
    rename_table :contest_rule, :contest_rules
    rename_table :contest_group, :contest_groups
    rename_table :contest_group_team, :contest_group_teams
  end
end