class UserOrganization < ApplicationRecord
	belongs_to :user
	belongs_to :organization

	attribute :user_id, :integer
	attribute :organization_id, :integer
	attribute :is_admin, :boolean
end
