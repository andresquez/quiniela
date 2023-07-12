class Role < ApplicationRecord

    validates :role, presence: true, uniqueness: true

    has_many :player

    
end
