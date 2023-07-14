class Player < ApplicationRecord

    # validations
    validates :username, presence: true, uniqueness: true
    validates :password, presence: true

    # associations
    belongs_to :role
    has_many :predictions

    # enums
    enum status: {
        active: "active",
        inactive: "inactive"
    }

    # callbacks
    after_create :update_leaderboard

    # methods
    def update_leaderboard
        Leaderboard.create(player_id: self.id, points: 0)
    end

end
