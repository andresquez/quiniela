class Leaderboard < ApplicationRecord

    validates :points, presence: true

    belongs_to :player

end
