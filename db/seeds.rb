# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
# User.delete_all
# Team.delete_all
ContestGroup.delete_all
ContestGroupTeam.delete_all
EventRoundContest.delete_all

# ["Bridges", "Marrale", "Fogarty", "Pietsch", "Echerd", "Wingo", "Verner", "Varner", "Simmonds", "Gresham","Duffy", "Webb", "Smith", "Jackson", "Lapp", "McCrae", "Porter", "Hill", "Wright", "Wilson","Davis", "Boen", "Russel", "Foster", "White", "Bledsoe", "Barnes", "Phillips"].each do |last_name|
#     users = []
#     ["A", "B"].each do |first_name|
#         email = "#{first_name}#{last_name}@squacho.com"
#         organization_id = 1
#         phone = "5555555555"
#         password = "password"
#         password_confirmation = "password"

#         user = User.create(email: email, name: "#{first_name} #{last_name}", phone: phone, password: password, password_confirmation: password_confirmation)
#         users.push(user)
#     end
#     Team.create(name: "Team #{last_name}", image_url: "https://png.pngtree.com/png-vector/20210604/ourmid/pngtree-gray-network-placeholder-png-image_3416659.jpg", users: users)
# end

# #seed contests
# ["Spear Throw", "Home Run Derby", "Horse Shoes", "Flip Cup", "Bear Pong", "Bearsbee", "Hula Bowl", "Tug-o-War", "Egg Toss", "Potato Sack Race"].each.with_index do |contest, i|
#     Contest.create(
#         name: contest, 
#         image_url: "https://png.pngtree.com/png-vector/20210604/ourmid/pngtree-gray-network-placeholder-png-image_3416659.jpg", 
#         location: "Site #{i + 1}", 
#         no_of_practice_attempts: 3,
#         no_of_contest_attempts: 4, 
#         max_points_per_attempt: 3
#     )
# end

group_rounds = EventRound.where(round_type: "Group")
group_contests = Contest.where(name: ["Flip Cup", "Tug-o-War", "Potato Sack Race", "Egg Toss"])
team_rounds = EventRound.where.not(id: group_rounds)
team_contests = Contest.where.not(id: group_contests).first(team_rounds.count)
teams = Team.all
teams_count = teams.count

# group_rounds.each.with_index do |round, i|
#     group_size = teams_count / 2
#     contest = group_contests[i]
#     EventRoundContest.create(event_round_id: round.id, contest_id: contest.id)
#     team_groups = teams.shuffle.each_slice(group_size)
#     team_groups.each do |teams_group|
#         contest_group = ContestGroup.create(
#             contest_id: contest.id, 
#             event_round_id: round.id, 
#             name: "Carnies", 
#             image_url: "https://png.pngtree.com/png-vector/20210604/ourmid/pngtree-gray-network-placeholder-png-image_3416659.jpg"
#         )
#         teams_group.each do |team|
#             ContestGroupTeam.create(contest_group_id: contest_group.id, team_id: team.id, event_round_id: round.id)
#         end
#     end
# end

group_sizes_per = []
team_rounds.count.times {|i| group_sizes_per.push(0)}
teams_count.times { group_sizes_per[group_sizes_per.index(group_sizes_per.min)] += 1 }

contest_teams_per_round = {}

team_contests.each.with_index do |contest, i|
    used_ids = []
    team_rounds.count.times do |n|
        puts("ROUND: #{n}")
        available_team_ids = teams.all.map(&:id)
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

# team_contests.each do |contest|
#     used = []
#     team_rounds.count.times do |n|
#         not_first_pass = contest_teams_per_round.has_key?(contest.id)
#         index = n - 1
#         if not_first_pass
#             existing_ids = contest_teams_per_round[contest.id]
#             puts("EXISTING: #{existing_ids}")
#             # used_and_existing = used.concat(existing_ids).flatten.uniq
#             puts("USED: #{used}")
#             available_teams = teams.where.not(id: [used, existing_ids].flatten).shuffle
#         elsif used.any?()
#             available_teams = teams.where.not(id: used).shuffle
#         else
#             available_teams = teams.all.shuffle
#         end
#         size = group_sizes_per[index]
#         puts("SIZE: #{size}")
#         puts("AVAILABLE: #{available_teams.count}")
#         group = available_teams.take(size)
#         puts(group.map(&:id))
#         ids = group.map(&:id)
#         if not_first_pass
#             contest_teams_per_round[contest.id].push(ids)
#         else
#             contest_teams_per_round[contest.id] = [ids]
#         end
#         used.concat(ids)
#     end
# end
# byebug
puts(contest_teams_per_round)

team_rounds.each.with_index do |round, i|
    used_team_ids = []
    puts("ROUND: #{round.order}")

    puts("GROUP SIZES PER: #{group_sizes_per}")
    contest_teams_per_round.each do |index, rounds|
        contest_id = team_contests[index].id
        puts("CONTEST ID: #{contest_id}")
        EventRoundContest.create(event_round_id: round.id, contest_id: contest_id)
        teams_group = rounds[i]
        puts("TEAMS IDS: #{teams_group}")
        contest_group = ContestGroup.create(
            contest_id: contest_id,
            event_round_id: round.id,
            name: "Group #{contest_id}-#{round.order}", 
            image_url: "https://png.pngtree.com/png-vector/20210604/ourmid/pngtree-gray-network-placeholder-png-image_3416659.jpg"
        )
        teams_group.each do |team_id|
            ContestGroupTeam.create(contest_group_id: contest_group.id.to_s, team_id: team_id.to_s, event_round_id: round.id)
        end
    end

    puts("-------------------------------------")
end

# puts("SUCCESS!!!")