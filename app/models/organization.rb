class Organization < ApplicationRecord
	attribute :name, :string
	attribute :email, :string
	attribute :phone, :string
	attribute :address, :string
	attribute :city, :string
	attribute :state, :string
	attribute :zip_code, :string
	attribute :image_url, :string

	has_many :events
end
