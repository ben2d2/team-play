User.delete_all
Team.delete_all
UserTeam.delete_all
Contest.delete_all
ContestGroup.delete_all
ContestGroupTeam.delete_all
EventRoundContest.delete_all

organization = Organization.first
# teams = Team.all

#seed contests
["Spear Throw", "Home Run Derby", "Horse Shoes", "Flip Cup", "Bear Pong", "Bearsbee", "Hula Bowl", "Tug-o-War", "Egg Toss", "Potato Sack Race"].each.with_index do |contest, i|
    Contest.create(
        name: contest, 
        image_url: "https://png.pngtree.com/png-vector/20210604/ourmid/pngtree-gray-network-placeholder-png-image_3416659.jpg", 
        location: "Site #{i + 1}", 
        no_of_practice_attempts: 3,
        no_of_contest_attempts: 4, 
        max_points_per_attempt: 3,
        organization_id: organization.id
    )
end

event = organization.organization_events.map(&:event).first
event_rounds = event.event_rounds


teams = []
["Bridges", "Marrale", "Fogarty", "Pietsch", "Echerd", "Wingo", "Verner", "Varner", "Simmonds", "Gresham","Duffy", "Webb", "Smith", "Jackson", "Lapp", "McCrae", "Porter", "Hill", "Wright", "Wilson","Davis", "Boen", "Russel", "Foster", "White", "Bledsoe", "Barnes", "Phillips"].each do |last_name|
    users = []
    ["A", "B"].each do |first_name|
        email = "#{first_name}#{last_name}@squacho.com"
        organization_id = organization.id
        phone = "5555555555"
        password = "password"
        password_confirmation = "password"

        user = User.create(email: email, name: "#{first_name} #{last_name}", phone: phone, password: password, password_confirmation: password_confirmation)
        users.push(user)
    end
    team = Team.new(event_id: event.id, name: "Team #{last_name}", image_url: "https://png.pngtree.com/png-vector/20210604/ourmid/pngtree-gray-network-placeholder-png-image_3416659.jpg")
    team.save
    teams.push(team)
    users.each do |user|
        UserTeam.create(user_id: user.id, team_id: team.id)
    end
end

group_event_rounds = event_rounds.where(round_type: "Group")
group_type_contests = Contest.where(name: ["Flip Cup", "Tug-o-War", "Potato Sack Race", "Egg Toss"])

team_event_rounds = event_rounds.where.not(id: group_event_rounds)
team_type_contests = Contest.where.not(id: group_type_contests).first(team_event_rounds.count)

group_sizes_per = []
team_event_rounds.count.times {|i| group_sizes_per.push(0)}
teams.count.times { group_sizes_per[group_sizes_per.index(group_sizes_per.min)] += 1 }

contest_teams_per_round = {}

team_type_contests.each.with_index do |contest, i|
    used_ids = []
    team_event_rounds.count.times do |n|
        puts("ROUND: #{n}")
        available_team_ids = teams.map(&:id)
        used_for_contest_ids = contest_teams_per_round.map { |k, v| v[i] }.flatten
        available_team_ids = available_team_ids - used_ids

        if !used_for_contest_ids.nil?
            available_team_ids = available_team_ids - used_for_contest_ids
        end

        ids = available_team_ids.shuffle.first(group_sizes_per[n])
        puts("CONTEST #{i} IDS: #{ids}")
        if contest_teams_per_round.has_key?(n)
            contest_teams_per_round[n].push(ids)
        else
            contest_teams_per_round[n] = [ids]
        end
        used_ids.concat(ids)
    end

    group_sizes_per = group_sizes_per.rotate(1)

    puts("------------------------------------------")
end

foo = {}
contest_teams_per_round.each do |k, v|
    v.each do |ids|
        if foo.has_key?(k)
            foo[k].push(ids)
        else
            foo[k] = [ids]
        end
    end
end
foo = foo.map do |k, v|
    k = v.flatten.count
end
puts(foo)
puts(contest_teams_per_round)

team_event_rounds.each.with_index do |round, i|
    used_team_ids = []
    puts("ROUND: #{round.order}")

    puts("GROUP SIZES PER: #{group_sizes_per}")
    contest_teams_per_round.each do |index, rounds|
        contest_id = team_type_contests[index].id
        event_round_id = round.id
        event_id = event.id
        teams_group = rounds[i]
        teams_group.each do |team_id|
            EventTeamContest.create(event_id: event_id, contest_id: contest_id, team_id: team_id, event_round_id: event_round_id)
        end
    end

    puts("-------------------------------------")
end

puts("SUCCESS!!!")