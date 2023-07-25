class Match < ApplicationRecord


    # validations
    validates :team1_id, presence: true
    validates :team2_id, presence: true
    validate :different_teams


    # associations
    has_many :prediction
    has_many :team

    # callbacks
    after_destroy :delete_predictions

    # methods

    def different_teams
        if self.team1_id == self.team2_id
            errors.add(:team1_id, "can't be the same as team2_id")
        end
    end

    
    # delete all predictions for a match after match was deleted
    def delete_predictions
        Prediction.where(match_id: self.id).destroy_all
    end


end
