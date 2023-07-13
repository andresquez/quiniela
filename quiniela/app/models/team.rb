class Team < ApplicationRecord
    
        validates :name, presence: true, uniqueness: true
    
        # belongs_to :match
end
