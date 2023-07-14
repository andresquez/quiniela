# Task to update all users points 

namespace :update_points do
    desc "This task updates all users points bases on the points awarded for each prediction"
    task :update_points => :environment do
        Prediction.check_awarded_points
        Leaderboard.update_leaderboard
    end
end