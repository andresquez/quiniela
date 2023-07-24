class Prediction < ApplicationRecord
    
    # validations
    validates :player_id, presence: true
    validates :match_id, presence: true
    validates :goals1, presence: true
    validates :goals2, presence: true
    
    # associations
    belongs_to :player
    belongs_to :match
    
    # callbacks
    before_create :check_not_duplicate


    # methods
    # update awarded points based on the match result
    def self.check_awarded_points(match_id)
        Prediction.where(match_id: match_id).find_each do |prediction|
        if prediction.match.goals1.nil? || prediction.match.goals2.nil?
            prediction.update(points_awarded: 0)
        else
            points_awarded = 0
            # if match result is the same as prediction
            if prediction.goals1 == prediction.match.goals1 && prediction.goals2 == prediction.match.goals2
            points_awarded = 3
            # if match team 1 or team 2 goals are the same as prediction
            elsif prediction.goals1 == prediction.match.goals1 || prediction.goals2 == prediction.match.goals2
            points_awarded = 1
            # if winner is the same as prediction + 1
            if (prediction.match.goals1 > prediction.match.goals2 && prediction.goals1 > prediction.goals2) || (prediction.match.goals1 < prediction.match.goals2 && prediction.goals1 < prediction.goals2)
                points_awarded = 2
            end
            # if match team 1 or team 2 goals difference is the same as prediction
            elsif prediction.goals1 - prediction.goals2 == prediction.match.goals1 - prediction.match.goals2
            points_awarded = 1
            # if winner is the same as prediction + 1
            if (prediction.match.goals1 > prediction.match.goals2 && prediction.goals1 > prediction.goals2) || (prediction.match.goals1 < prediction.match.goals2 && prediction.goals1 < prediction.goals2)
                points_awarded = 2
            end
            end
            prediction.update(points_awarded: points_awarded)
        end
        end
    end
  

    # check if prediction for the same match already exists
    # if it does, cancel the creation of the new prediction

    def check_not_duplicate
        Prediction.all.each do |prediction|
            if prediction.player_id == self.player_id && prediction.match_id == self.match_id
                return false
            end
        end
    end

end
