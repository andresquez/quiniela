class Match < ApplicationRecord
    validates: :date_played , presence: true
    validates: :team1_id, presence: true
    validates: :team2_id, presence: true
    validates: :goals1, presence: true
    validates: :goals2, presence: true

    has_and_belongs_to_many :team
    belongs_to :prediction
end
