class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attribute :name, :string
  attribute :phone, :string
  attribute :email, :string
  attribute :team_id, :integer

  def is_admin
    user_organizations.map(&:is_admin).select { |i| i == true }.any? 
  end
  
  has_many :user_teams
  has_and_belongs_to_many :teams, class_name: 'Team', join_table: 'user_teams'

  has_many :user_organizations
  has_and_belongs_to_many :organizations, class_name: 'Organization', join_table: 'user_organizations'
end