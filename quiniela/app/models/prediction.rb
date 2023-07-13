class Prediction < ApplicationRecord

    validates :player_id, presence: true
    validates :match_id, presence: true
    validates :goals1, presence: true
    validates :goals2, presence: true

    belongs_to :player
    belongs_to :match

end
