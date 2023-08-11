class Organization < ApplicationRecord
	attribute :name, :string
	attribute :email, :string
	attribute :phone, :string
	attribute :address, :string
	attribute :city, :string
	attribute :state, :string
	attribute :zip_code, :string
	attribute :image_url, :string

	has_many :organization_events
  	has_and_belongs_to_many :events, class_name: 'Event', join_table: 'organization_events'
end
