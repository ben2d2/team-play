class ContestGroup < ApplicationRecord
	attribute :contest_id, :string
	attribute :name, :string
	attribute :image_url, :string
	attribute :event_round_id, :integer

	belongs_to :contest
	belongs_to :event_round
end
