class Player < ApplicationRecord

    validates :username, presence: true, uniqueness: true
    validates :password, presence: true

    belongs_to :role
    has_many :predictions

    enum status: {
        active: "active",
        inactive: "inactive"
    }

    # after_create :update_leaderboard

    # def update_leaderboard
    #     Leaderboard.create(player_id: self.id, points: 0)
    # end

end
