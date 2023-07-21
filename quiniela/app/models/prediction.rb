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
    # after_create :check_awarded_points

    # methods
    # update awarded points based on the match result
    def self.check_awarded_points
        Prediction.all.each do |prediction|
            # reset awarded points
            prediction.update(points_awarded: 0)
            # if match result is the same as prediction
            if prediction.goals1 == prediction.match.goals1 && prediction.goals2 == prediction.match.goals2
                prediction.update(points_awarded: 3)
                # if match team 1 or team 2 goals are the same as prediction
            elsif prediction.goals1 = prediction.match.goals1 || prediction.goals2 == prediction.match.goals2
                prediction.update(points_awarded: 1)
                # if match team 1 or team 2 goals difference is the same as prediction
            elsif prediction.goals1 - prediction.goals2 == prediction.match.goals1 - prediction.match.goals2
                prediction.update(points_awarded: 1)
                # if match result doesnt match any of the point awarding criteria
            else
                prediction.update(points_awarded: 0)
            end
        end
    end
end
