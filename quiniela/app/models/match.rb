class Match < ApplicationRecord

    # validations
    validates :team1_id, presence: true
    validates :team2_id, presence: true
    validates :goals1, presence: true
    validates :goals2, presence: true

    # associations
    has_many :prediction
    has_many :team

    # callbacks
    after_create :update_leaderboard

    # methods

    # insert results for a match after match ended and update the predictions and then the whole leaderboard
    def self.match_ended(match_id, goals1, goals2)
        Match.find(match_id).update(goals1: goals1, goals2: goals2)
        Prediction.check_awarded_points
        Leaderboard.update_leaderboard
    end
    
end
