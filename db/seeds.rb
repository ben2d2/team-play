User.delete_all
UserOrganization.delete_all
Team.delete_all
UserTeam.delete_all
Contest.delete_all
ContestGroup.delete_all
EventTeamContest.delete_all

stock_image_url = "https://rehabconceptspt.com/wp-content/uploads/2016/06/placeholder-640-square.jpg"
organization = Organization.first
event = organization.organization_events.map(&:event).first
event_rounds = event.event_rounds

#seed contests
["Spear Throw", "Home Run Derby", "Horse Shoes", "Flip Cup", "Bear Pong", "Bearsbee", "Hula Bowl", "Tug-o-War", "Egg Toss", "Potato Sack Race"].each.with_index do |contest, i|
    Contest.create(
        name: contest, 
        image_url: stock_image_url, 
        location: "Site #{i + 1}", 
        no_of_practice_attempts: 3,
        no_of_contest_attempts: 4, 
        max_points_per_attempt: 3,
        organization_id: organization.id,
        contest_type: ["Flip Cup", "Tug-o-War", "Potato Sack Race", "Egg Toss"].include?(contest) ? "Group" : "Team"
     )
end

["Fitzpatrick", "Bridges", "Marrale", "Fogarty", "Pietsch", "Echerd", "Wingo", "Verner", "Varner", "Simmonds", "Gresham","Duffy", "Webb", "Smith", "Jackson", "Lapp", "McCrae", "Porter", "Hill", "Wright", "Wilson","Davis", "Boen", "Russel", "Foster", "White", "Bledsoe", "Barnes", "Phillips", "Vinson"].each do |last_name|
    users = []
    ["A", "B"].each do |first_name|
        name = "#{first_name} #{last_name}"
        email = "#{first_name}#{last_name}@squacho.com"
        organization_id = organization.id
        phone = "5555555555"
        password = "password"
        password_confirmation = "password"
        is_admin = name == "A Bridges"

        user = User.create(email: email, name: name, phone: phone, password: password, password_confirmation: password_confirmation)
        users.push(user)
        UserOrganization.create(user_id: user.id, organization_id: organization.id)
    end
    team = Team.new(event_id: event.id, name: "Team #{last_name}", image_url: stock_image_url)
    team.save
    users.each do |user|
        UserTeam.create(user_id: user.id, team_id: team.id)
    end
end

teams = event.teams

# GROUP ROUNDS/CONTESTS GENERATOR
group_rounds = event_rounds.where(round_type: "Group")
group_contests = Contest.where(contest_type: "Group").shuffle

group_rounds.each.with_index do |round, i|
    contest = group_contests[i]
    groups_teams = teams.shuffle.each_slice(teams.count / 2)
    
    groups_teams.each.with_index do |groups, gi|
        
        contest_group = ContestGroup.create(
            contest_id: contest.id,
            event_round_id: round.id,
            name: "Group #{gi + 1}: #{contest.name}",
            image_url: stock_image_url
        )
        groups.each do |team|
            etc = EventTeamContest.new(
                event_id: event.id,
                contest_id: contest.id,
                team_id: team.id,
                event_round_id: round.id,
                contest_group_id: contest_group.id
            )

            etc.save!
        end
    end
end

# ------------------------------------------------------------------

# TEAM ROUNDS/CONTESTS GENERATOR
team_rounds = event_rounds.where.not(id: group_rounds)
team_contests = Contest.where.not(id: group_contests).first(team_rounds.count)
team_trackers = teams.map { |t| [t.id, { contests: [] }] }.to_h
final_rounds = {}
contest_slot = 0
team_rounds.each do |round|
    contest_slots = team_contests.map {|contest| [contest.id, []]}.to_h
    assigned_teams_for_round = [] 

    while assigned_teams_for_round.count < teams.count do
        contest = team_contests[contest_slot]

        potential_teams = teams.select do |team|
            !team_trackers[team.id][:contests].include?(contest.id) && !assigned_teams_for_round.include?(team.id)
        end

        contest_slot = (contest_slot + 1) % team_contests.count;

        if potential_teams.count > 0
            chosen_team = potential_teams.shuffle.first
            team_trackers[chosen_team.id][:contests].push(contest.id) #Mark that the team has been assigned this contest in any round
            assigned_teams_for_round.push(chosen_team.id) #Mark that this team has been assigned a contest for this round

            contest_slots[contest.id].push(chosen_team.id) #Add this team to the current contest for this round
        end            
    end
    final_rounds[round.id] = contest_slots
end

final_rounds.each do |round_id, contests|
    contests.each do |contest_id, team_ids|
        team_ids.each do |id|
            etc = EventTeamContest.new(
                event_id: event.id,
                contest_id: contest_id,
                team_id: id,
                event_round_id: round_id,
                contest_group_id: nil
            )
            etc.save!
        end
    end
end

# total_per_round_contest = EventTeamContest.all.group_by {|etc| "#{etc.event_round_id}-#{etc.contest_id}"}.map do |key, team_etcs|
#     [
#         key, 
#         team_etcs.count
#     ]
# end.to_h
# puts(total_per_round_contest.to_json)

puts("SUCCESS!!!")