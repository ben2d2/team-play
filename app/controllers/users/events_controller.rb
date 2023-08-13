class Users::EventsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
		@event = Event.where(
      id: event_params[:id]
    ).first

    event_team = current_user.user_teams.map(&:team).select {|t| t.event_id ==  @event.id}.first

    @scorecard = ScorecardPresenter.presenter(@event, event_team)

    @rounds = @event.event_team_contests.where(team_id: event_team.id).sort_by { |etc| etc.event_round.order }.map do |etc|
      RoundPresenter.presenter(etc.contest, etc.event_round.order)
    end
	end

	private
	def event_params
    params.permit(:id)
  end
end