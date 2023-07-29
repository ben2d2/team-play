class ContestGroupTeam < ApplicationRecord
	attribute :contest_group_id, :string
	attribute :team_id, :string
	attribute :points, :integer
end
