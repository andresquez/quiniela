# seed for development environment

# create teams
20.times do
    Team.create(
        name: Faker::Team.name
    )
end

# create roles
Role.find_or_create_by(role: "player")
Role.find_or_create_by(role: "admin")

# create player
5.times do
    Player.create(
        username: Faker::Internet.username, 
        password: Faker::Internet.password, 
        role_id: 1
    )
end


# create matches
20.times do
    Match.create(
        date_played: Faker::Date.between(from: '2020-05-01', to: '2021-05-01'),
        team1_id: rand(1..20),
        team2_id: rand(1..20), 
        goals1: rand(1..5), 
        goals2: rand(1..5)
    )
end

# create predictions
20.times do
    Prediction.create(
        player_id: rand(1..5), 
        match_id: rand(1..20), 
        goals1: rand(0..5), 
        goals2: rand(0..5),
        points_awarded: rand(0..3)
    )
end

# # create leaderboards
# 5.times do
#     Leaderboard.create(
#         points: rand(0..20),
#         player_id: rand(1..5)
#     )
# end

# create admin
Player.create(
    username: "admin", 
    password: "admin", 
    role_id: 2
)
