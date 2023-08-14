class LeaderboardTeamPresenter
    def self.presenter(event, team)
        rank = TeamRankHelper.rank_team(event, team)
        team_users = team.user_teams.map(&:user)
        size = 60
        size = 72 if [2, 3].include?(rank)
        size = 100 if rank == 1
        {
            id: team.id,
            pre_row: rank,
            link: nil,
            avatar: team.image_url,
            name: team.name,
            details: "#{team.event_team_contests.sum { |etc| !etc.score.nil? ? etc.score : 0 }} pts.",
            size: size
        }
    end
end