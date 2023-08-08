class Event < ApplicationRecord
	attribute :name, :string
	attribute :image_url, :string
	attribute :start_time, :datetime
	attribute :end_time, :datetime
	attribute :location, :string
	attribute :organization_id, :integer

	has_one :organization
	has_many :event_rounds
end
