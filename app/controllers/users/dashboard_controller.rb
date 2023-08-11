class Users::DashboardController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @organizations = current_user.user_organizations.map do |user_organization|
      {
        place: nil,
        avatar: "https://static.thenounproject.com/png/2754531-200.png",
        name: user_organization.organization.name,
        details: nil,
        size: 72
      }
    end

    @events = current_user.user_organizations.map do |user_organization|
      organization = user_organization.organization
      events = organization.organization_events.map(&:event).select {|event| event.start_time >= Time.now }.map do |event|
        {
          place: nil,
          avatar: event.image_url,
          name: event.name,
          details: event.start_time.strftime("%m/%d/%y %l:%M%p"),
          size: 72
        }
      end
    end.flatten
    render
  end
end