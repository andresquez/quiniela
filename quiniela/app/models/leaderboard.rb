class Leaderboard < ApplicationRecord

    validates :player_id, presence: true, uniqueness: true
    validates :points, presence: true

    belongs_to :player

end
