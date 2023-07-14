class Leaderboard < ApplicationRecord

    # validations
    validates :points, presence: true

    # associations
    belongs_to :player

    # methods

    # update leaderboard based on the predictions of each player
    def self.update_leaderboard
        Leaderboard.all.each do |leaderboard|
            leaderboard.update(points: 0)
        end
        Prediction.all.each do |prediction|
            leaderboard = Leaderboard.find_by(player_id: prediction.player_id)
            leaderboard.update(points: leaderboard.points + prediction.points_awarded)
        end
    end
end
