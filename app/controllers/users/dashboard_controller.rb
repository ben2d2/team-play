class Users::DashboardController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @organizations = current_user.user_organizations.where(is_admin: true).map do |user_organization|
      {
        pre_row: nil,
        avatar: "https://static.thenounproject.com/png/2754531-200.png",
        name: user_organization.organization.name,
        details: "Edit",
        size: 72,
        link: nil
      }
    end

    @current_events = current_user.user_organizations.map do |user_organization|
      organization = user_organization.organization
      events = organization.organization_events.map(&:event).select {|event| event.start_time >= Time.now }.map do |event|
        {
          pre_row: nil,
          avatar: event.image_url,
          name: event.name,
          details: event.start_time.strftime("%m/%d/%y %l:%M%p"),
          size: 72,
          link: "/users/events/#{event.id}"
        }
      end
    end.flatten

    @upcoming_events = current_user.user_organizations.map do |user_organization|
      organization = user_organization.organization
      events = organization.organization_events.map(&:event).select {|event| event.start_time < Time.now }.map do |event|
        {
          pre_row: nil,
          avatar: event.image_url,
          name: event.name,
          details: event.start_time.strftime("%m/%d/%y %l:%M%p"),
          size: 72,
          link: nil
        }
      end
    end.flatten
    render
  end
end