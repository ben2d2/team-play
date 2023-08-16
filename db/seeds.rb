User.delete_all
UserOrganization.delete_all
Team.delete_all
UserTeam.delete_all
Contest.delete_all
EventTeamContest.delete_all

organization = Organization.first

#seed contests
["Spear Throw", "Home Run Derby", "Horse Shoes", "Flip Cup", "Bear Pong", "Bearsbee", "Hula Bowl", "Tug-o-War", "Egg Toss", "Potato Sack Race"].each.with_index do |contest, i|
    Contest.create(
        name: contest, 
        image_url: "https://png.pngtree.com/png-vector/20210604/ourmid/pngtree-gray-network-placeholder-png-image_3416659.jpg", 
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
    team = Team.new(event_id: event.id, name: "Team #{last_name}", image_url: "https://png.pngtree.com/png-vector/20210604/ourmid/pngtree-gray-network-placeholder-png-image_3416659.jpg")
    team.save
    users.each do |user|
        UserTeam.create(user_id: user.id, team_id: team.id)
    end
end

event = organization.organization_events.map(&:event).first
event_rounds = event.event_rounds
teams = event.teams

# GROUP ROUNDS/CONTESTS GENERATOR
group_event_rounds = event_rounds.where(round_type: "Group")
group_type_contests = Contest.where(contest_type: "Group")

# ------------------------------------------------------------------

# TEAM ROUNDS/CONTESTS GENERATOR
team_rounds = event_rounds.where.not(id: group_event_rounds)
team_contests = Contest.where.not(id: group_type_contests).first(team_rounds.count)
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
            EventTeamContest.create(
                event_id: event.id,
                contest_id: contest_id,
                team_id: id,
                event_round_id: round_id
            )
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