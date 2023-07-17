class Team < ApplicationRecord
    
    # Files attached to the team model
    has_one_attached :logo
    has_one_attached :team_photo

    # validations
    validates :name, presence: true, uniqueness: true
    

end
