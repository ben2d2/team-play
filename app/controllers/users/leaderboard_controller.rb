class Users::LeaderboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @event = Event.where(
      id: event_params[:event_id]
    ).first

    event_team_contests = @event.event_team_contests

    leaderboard_teams = @event.teams.map do |team|
      rank = TeamRankHelper.rank_team(@event, team)
      team_users = team.user_teams.map(&:user)
      {
        pre_row: rank,
        link: nil,
        avatar: team.image_url,
        name: team.name,
        details: "#{team.event_team_contests.sum { |etc| !etc.score.nil? ? etc.score : 0 }} pts.",
        size: 72
      }
    end
``
    @leaders = []
    leaders_sort_order = [2, 1, 3]
    leaderboard_teams.select { |team| !team[:pre_row].nil? && team[:pre_row] <= 3 }.each do |team|
      index = leaders_sort_order.find_index(team[:pre_row])
      if team[:pre_row] == 1
        team[:size] = 100
      end
      @leaders[index] = team
    end
    @the_rest_of_the_field = leaderboard_teams.select { |team| !team[:pre_row].nil? && team[:pre_row] > 3 }.sort_by { |team| team[:pre_row] }

    render
  end

	private
	def event_params
    params.permit(:event_id)
  end
end