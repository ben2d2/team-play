class EventRoundContest < ApplicationRecord
	belongs_to :event_round
	belongs_to :contest

	attribute :event_round_id, :string
	attribute :contest_id, :string
end
