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
    def update_leaderboard
        Leaderboard.update_leaderboard
    end
   
end
