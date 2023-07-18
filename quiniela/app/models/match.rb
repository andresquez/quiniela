class Match < ApplicationRecord

    # validations
    validates :team1_id, presence: true
    validates :team2_id, presence: true
    # validates :goals1, presence: true
    # validates :goals2, presence: true

    # associations
    has_many :prediction
    has_many :team

    # callbacks
    after_update  :match_ended

    # methods

    # insert results for a match after match ended and update the predictions and then the whole leaderboard
    def match_ended
        match = Match.find(self.id)
        match.update(goals1: self.goals1, goals2: self.goals2)
        Prediction.check_awarded_points
        Leaderboard.update_leaderboard
    end
    
end
