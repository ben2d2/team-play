class UserTeam < ApplicationRecord
	belongs_to :user
	belongs_to :team

	attribute :user_id, :integer
	attribute :team_id, :integer
end
