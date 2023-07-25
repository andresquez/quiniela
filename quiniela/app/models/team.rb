class Team < ApplicationRecord
    
    # Files attached to the team model
    has_one_attached :logo
    has_one_attached :team_photo

    # validations
    validates :name, presence: true, uniqueness: true
    
    # callbacks
    after_destroy :delete_matches

    # methods

    # delete all matches for a team after team was deleted
    def delete_matches
        Match.where(team1_id: self.id).destroy_all
        Match.where(team2_id: self.id).destroy_all
    end
    
end
