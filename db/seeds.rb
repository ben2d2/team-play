# User.delete_all
# UserOrganization.delete_all
# Team.delete_all
# UserTeam.delete_all
# Contest.delete_all
EventTeamContest.delete_all

organization = Organization.first

#seed contests
# ["Spear Throw", "Home Run Derby", "Horse Shoes", "Flip Cup", "Bear Pong", "Bearsbee", "Hula Bowl", "Tug-o-War", "Egg Toss", "Potato Sack Race"].each.with_index do |contest, i|
#     Contest.create(
#         name: contest, 
#         image_url: "https://png.pngtree.com/png-vector/20210604/ourmid/pngtree-gray-network-placeholder-png-image_3416659.jpg", 
#         location: "Site #{i + 1}", 
#         no_of_practice_attempts: 3,
#         no_of_contest_attempts: 4, 
#         max_points_per_attempt: 3,
#         organization_id: organization.id
#     )
# end

event = organization.organization_events.map(&:event).first
event_rounds = event.event_rounds
teams = event.teams

# teams = []
# ["Bridges", "Marrale", "Fogarty", "Pietsch", "Echerd", "Wingo", "Verner", "Varner", "Simmonds", "Gresham","Duffy", "Webb", "Smith", "Jackson", "Lapp", "McCrae", "Porter", "Hill", "Wright", "Wilson","Davis", "Boen", "Russel", "Foster", "White", "Bledsoe", "Barnes", "Phillips"].each do |last_name|
#     users = []
#     ["A", "B"].each do |first_name|
#         name = "#{first_name} #{last_name}"
#         email = "#{first_name}#{last_name}@squacho.com"
#         organization_id = organization.id
#         phone = "5555555555"
#         password = "password"
#         password_confirmation = "password"
#         is_admin = name == "A Bridges"

#         user = User.create(email: email, name: name, phone: phone, password: password, password_confirmation: password_confirmation)
#         users.push(user)
#         UserOrganization.create(user_id: user.id, organization_id: organization.id)
#     end
#     team = Team.new(event_id: event.id, name: "Team #{last_name}", image_url: "https://png.pngtree.com/png-vector/20210604/ourmid/pngtree-gray-network-placeholder-png-image_3416659.jpg")
#     team.save
#     teams.push(team)
#     users.each do |user|
#         UserTeam.create(user_id: user.id, team_id: team.id)
#     end
# end

group_event_rounds = event_rounds.where(round_type: "Group")
group_type_contests = Contest.where(name: ["Flip Cup", "Tug-o-War", "Potato Sack Race", "Egg Toss"])

team_event_rounds = event_rounds.where.not(id: group_event_rounds)
team_type_contests = Contest.where.not(id: group_type_contests).first(team_event_rounds.count)

group_sizes_per = []
team_event_rounds.count.times {|i| group_sizes_per.push(0)}
teams.count.times { group_sizes_per[group_sizes_per.index(group_sizes_per.min)] += 1 }

ids_per_contest = team_type_contests.map do |contest| 
    [contest.id, []]
end.to_h

team_event_rounds.each.with_index do |round, r|
    team_type_contests.each.with_index do |contest, c|
        max_per = group_sizes_per[r]
        available_teams = teams.where.not(id: ids_per_contest[contest.id].flatten).shuffle
        picked_teams = available_teams.pop(max_per).map(&:id)
        ids_per_contest[contest.id].push(picked_teams)
    end
end

puts(ids_per_contest.to_json)

ids_per_contest.each do |contest_id, team_ids_list|
    team_event_rounds.each.with_index do |round, ri|
        team_ids_list[ri].each do |id|
            EventTeamContest.create(
                event_id: event.id,
                contest_id: contest_id,
                team_id: id,
                event_round_id: round.id
            )
        end
    end
end

EventTeamContest.all.group_by(&:team_id).map do |team_id, team_etcs|
    [
        team_id, 
        team_etcs.group_by(&:contest_id).map do |contest_id, team_contest_etcs|
            [contest_id, team_contest_etcs.count]
        end.to_h
    ]
end.to_h

puts("SUCCESS!!!")