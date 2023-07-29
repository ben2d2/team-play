class ContestRule < ApplicationRecord
	attribute :contest_id, :string
	attribute :description, :string
	attribute :order, :integer
end
