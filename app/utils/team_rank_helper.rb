class TeamRankHelper
    def self.rank_team(event, team)
        team_scores = event.event_team_contests.group_by(&:team_id).map do |k,v|
            { 
                team_id: k,
                score: v.sum { |etc| !etc.score.nil? ? etc.score : 0 }
            }
        end
    
        score_groups = team_scores.sort_by { |ts| ts[:score] }.reverse.group_by do |ts|
            ts[:score]
        end.map.with_index do |(k, score_group), i|
            {
                score: k,
                team_ids: score_group.map { |sg| sg[:team_id] },
                rank: i + 1
            }
        end
    
        current_team_score_group = score_groups.select do |score_group|
        score_group[:team_ids].include?(team.id.to_s)
        end.first
        
        rank = current_team_score_group[:rank]

        rank
    end
end