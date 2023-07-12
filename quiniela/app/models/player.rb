class Player < ApplicationRecord

    validates :username, presence: true, uniqueness: true
    validates :password, presence: true

    has_one :role
    has_many :prediction

    # after_create :update_leaderboard

    def update_leaderboard
        Leaderboard.create(self.id, points: 0)
    end

end
