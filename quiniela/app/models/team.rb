class Team < ApplicationRecord
    
        # validations
        validates :name, presence: true, uniqueness: true
    
        # associations
        # belongs_to :match
        
end
