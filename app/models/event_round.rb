class EventRound < ApplicationRecord
	attribute :event_id, :string
	attribute :type, :string #can be "Group" or "Teams"
	attribute :order, :integer
end
