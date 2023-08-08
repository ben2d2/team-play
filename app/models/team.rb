class Team < ApplicationRecord
	attribute :name, :string
	attribute :image_url, :string
	has_many :user_teams
	has_and_belongs_to_many :users, class_name: 'User', join_table: 'user_teams'
end
