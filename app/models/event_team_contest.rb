class EventTeamContest < ApplicationRecord
    attribute :event_id, :string
	attribute :team_id, :string
	attribute :contest_id, :string
	attribute :event_round_id, :integer
	attribute :contest_group_id, :integer
	attribute :score, :integer

    belongs_to :event
    belongs_to :event_round
    belongs_to :team
    belongs_to :contest
end
