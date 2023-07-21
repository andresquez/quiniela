class Player < ApplicationRecord

    after_destroy :destroy_leaderboard, :destroy_predictions


    # validations
    validates :username, presence: true, uniqueness: true
    validates :password, presence: true

    # associations
    belongs_to :role
    has_many :predictions
    has_one :leaderboard

    # enums
    enum status: {
        active: "active",
        inactive: "inactive"
    }

    # callbacks
    after_create :update_leaderboard
    after_create :set_role_id

    # methods
    def update_leaderboard
        Leaderboard.create(player_id: self.id, points: 0)
    end

    def set_role_id
        self.update(role_id: 1)
    end

    def destroy_leaderboard
        self.leaderboard.destroy
    end

    def destroy_predictions
        self.predictions.destroy_all
    end
end
