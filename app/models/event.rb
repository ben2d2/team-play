class Event < ApplicationRecord
	attribute :name, :string
	attribute :image_url, :string
	attribute :start_time, :datetime
	attribute :end_time, :datetime
	attribute :location, :string
end
