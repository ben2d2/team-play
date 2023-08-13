class ScorecardPresenter
    def self.presenter(event, event_team)
        team_users = event_team.user_teams.map(&:user)
    
        rank = TeamRankHelper.rank_team(event, event_team)

        pre_row = "#{rank}#{rank.ordinal}"
        avatar = event_team.image_url
        avatar_size = 100
        title = event_team.name
        subtitle = team_users.map(&:name).join("/")
        scorecard_score = event_team.event_team_contests.sum { |etc| !etc.score.nil? ? etc.score : 0 }

        {
        pre_row: pre_row,
        link: nil,
        avatar: avatar,
        avatar_size: avatar_size,
        size: avatar_size,
        title: title,
        name: title,
        subtitle: subtitle,
        points: scorecard_score,
        details: "#{scorecard_score} pts."
        }
    end
end