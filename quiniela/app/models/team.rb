class Team < ApplicationRecord
    
        validates :name, presence: true, uniqueness: true
    
        has_many :match
end
