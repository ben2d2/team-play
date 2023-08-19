class RoundPresenter
    def self.presenter(event, event_team_contest)
        contest = event_team_contest.contest
        round_order = event_team_contest.event_round.order
        prev_round = EventRound.where(event_id: event.id, order: round_order - 1).first
        prev_score_exists = round_order == 1 ? false : !EventTeamContest.where(event_id: event.id, team_id: event_team_contest.team_id, event_round_id: prev_round.id).first.score.nil?
        {
            pre_row: round_order,
            link: prev_score_exists || round_order == 1 ? "/users/events/#{event.id}/scorecard/#{event_team_contest.id}" : nil,
            avatar: contest.image_url,
            name: contest.name,
            details: event_team_contest.score.nil? ? contest.location : "#{event_team_contest.score} pts.",
            size: 60
        }
    end
end