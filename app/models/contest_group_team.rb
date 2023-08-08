class ContestGroupTeam < ApplicationRecord
	attribute :contest_group_id, :string
	attribute :event_round_id, :integer
	attribute :team_id, :string
	attribute :points, :integer

	belongs_to :team
	belongs_to :event_round
end
