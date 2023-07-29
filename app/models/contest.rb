class Contest < ApplicationRecord
	attribute :name, :string
	attribute :image_url, :string
	attribute :location, :string
	attribute :no_of_practice_attempts, :integer
	attribute :no_of_contest_attempts, :integer
	attribute :max_points_per_attempt, :integer
end
