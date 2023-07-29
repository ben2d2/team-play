class OrganizationEvent < ApplicationRecord
	belongs_to :event
	belongs_to :organization

	attribute :event_id, :integer
	attribute :organization_id, :integer
end
