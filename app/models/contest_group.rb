class ContestGroup < ApplicationRecord
	attribute :contest_id, :string
	attribute :name, :string
	attribute :image_url, :string
	attribute :event_round_id, :integer

	belongs_to :contest
	has_many :contest_group_teams
	has_many :teams, through: :contest_group_teams
	belongs_to :event_round
end
