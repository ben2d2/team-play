class Users::ScorecardController < ApplicationController
  before_action :authenticate_user!

  def show
    @event = Event.where(
      id: scorecard_params[:event_id]
    ).first

    @event_team_contest = @event.event_team_contests.where(
      id: scorecard_params[:id]
    ).first

    @team_id = @event_team_contest.team.id

    event_round = @event_team_contest.event_round
    is_group_event = event_round.round_type == "Group"
    @round = event_round.order

    @scorecard = ScorecardPresenter.presenter(@event, @event_team_contest.team)

    contest = @event_team_contest.contest
    @contest = { 
      avatar: contest.image_url,
      name: contest.name,
      max_points: contest.max_points_per_attempt * contest.no_of_contest_attempts,
      contest_id: contest.id
    }
    leaderboard_teams = @event.teams.map do |team|
      LeaderboardTeamPresenter.presenter(@event, team)
    end

    if is_group_event
      @my_group = "SOME GROUP NAME"
      contest_group = ContestGroup.find(@event_team_contest.contest_group_id)
      contest_group_teams = @event.event_team_contests.where.not(team_id: @team_id).where(contest_group_id: contest_group.id, event_round_id: event_round.id).map do |etc|
        team = etc.team
        score_and_rank = leaderboard_teams.select { |lt| lt[:id] == team.id }.first
        {
          pre_row: nil,
          link: nil,
          avatar: team.image_url,
          name: team.name,
          size: 60,
          details: team.user_teams.map {|ut| ut.user.name }.join("/")
        }
      end.sort_by { |t| t[:name] }
      @my_group = {
        name: contest_group.name,
        teams: contest_group_teams
      }
    else
      @competition = @event.event_team_contests.where.not(team_id: @team_id).where(contest_id: contest.id, event_round_id: event_round.id).map do |etc|
        team = etc.team
        score_and_rank = leaderboard_teams.select { |lt| lt[:id] == team.id }.first
        {
          pre_row: nil,
          link: nil,
          avatar: team.image_url,
          name: team.name,
          size: 60,
          details: "#{score_and_rank[:pre_row]}#{score_and_rank[:pre_row].ordinal} - #{score_and_rank[:details]}"
        }
      end.sort_by { |t| t[:details] }.reverse
    end

    render
  end

  def update
    etc = EventTeamContest.where(id: scorecard_params[:id]).first
    etc.score = scorecard_params[:score]
    if etc.save!
      rounds_for_team = EventTeamContest.where(event_id: scorecard_params[:event_id], team_id: scorecard_params[:team_id])
      next_round_id = rounds_for_team.select { |rft| rft.event_round.order == scorecard_params[:round].to_i + 1 }.first.id
      flash[:success] = "Your score for #{etc.contest.name} has been saved"
      redirect_to "/users/events/#{scorecard_params[:event_id]}/scorecard/#{next_round_id}"
    else
      flash[:error] = "Your score for #{etc.contest.name} could not be saved"
      render
    end
  end

	private
	def scorecard_params
    params.permit(:event_id, :id, :score, :round, :team_id)
  end
end