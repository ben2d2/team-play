class Team < ApplicationRecord
	attribute :name, :string
	attribute :image_url, :string
	attribute :event_id, :integer

	belongs_to :event
	
	has_many :event_team_contests
	has_many :user_teams
end
