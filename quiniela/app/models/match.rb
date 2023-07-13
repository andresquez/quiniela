class Match < ApplicationRecord
    # validates :date_played 
    validates :team1_id, presence: true
    validates :team2_id, presence: true
    validates :goals1, presence: true
    validates :goals2, presence: true

    has_many :prediction
    has_many :team
    # belongs_to :team
    #
end
