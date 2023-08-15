class Contest < ApplicationRecord
	attribute :name, :string
	attribute :image_url, :string
	attribute :location, :string
	attribute :no_of_practice_attempts, :integer
	attribute :no_of_contest_attempts, :integer
	attribute :max_points_per_attempt, :integer
	attribute :organization_id, :integer
	attribute :contest_type, :string

	belongs_to :organization
	has_many :contest_groups
	has_many :event_team_contests
end
