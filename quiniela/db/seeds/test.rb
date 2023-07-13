# seed for development environment

# create teams
20.times do
    Team.create(name: Faker::Team.name)
end

# create player
5.times do
    Player.create(username: Faker::Internet.username, password: Faker::Internet.password, role_id: 1)
end

# create roles
Role.create(role: "player")
Role.create(role: "admin")

# create matches
20.times do
    Match.create(date_played: Faker::Date.between(from: '2020-05-01', to: '2021-05-01'), team1_id: rand(1..20), team2_id: rand(1..20), goals1:  )
end

# create predictions
20.times do
    Prediction.create(player_id: rand(1..5), match_id: rand(1..20), goals1: rand(0..5), goals2: rand(0..5))
end

# create leaderboards
5.times do
    Leaderboard.create(player_id: rand(1..5), points: rand(0..20))
end

# create admin
Player.create(username: "admin", password: "admin", role_id: 2)
