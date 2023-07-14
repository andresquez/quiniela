class Role < ApplicationRecord

    # validations
    validates :role, presence: true

    # associations
    has_many :player
    
end
