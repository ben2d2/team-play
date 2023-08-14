class Users::LeaderboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @event = Event.where(
      id: event_params[:event_id]
    ).first

    leaderboard_teams = @event.teams.map do |team|
      LeaderboardTeamPresenter.presenter(@event, team)
    end

    @leaders = []
    
    leaders_sort_order = [2, 1, 3]
    leaderboard_teams.select { |team| !team[:pre_row].nil? && team[:pre_row] <= 3 }.each do |team|
      index = leaders_sort_order.find_index(team[:pre_row])
      @leaders[index] = team
    end

    @the_rest_of_the_field = leaderboard_teams.select do |team| 
      !team[:pre_row].nil? && team[:pre_row] > 3
    end.sort_by { |team| team[:pre_row] }

    render
  end

	private
	def event_params
    params.permit(:event_id)
  end
end