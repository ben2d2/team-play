class RoundPresenter
    def self.presenter(event, event_team_contest)
        contest = event_team_contest.contest
        order = event_team_contest.event_round.order
        {
            pre_row: order,
            link: "/users/events/#{event.id}/scorecard/#{event_team_contest.id}",
            avatar: contest.image_url,
            name: contest.name,
            details: contest.location,
            size: 60
        }
    end
end