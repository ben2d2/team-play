class EventRound < ApplicationRecord
	attribute :event_id, :string
	attribute :round_type, :string #can be "Group" or "Teams"
	attribute :order, :integer

	belongs_to :event

	has_many :contest_group_teams
	has_many :event_round_contests
	has_and_belongs_to_many :contests, class_name: 'Contest', join_table: 'event_round_contests'
end
