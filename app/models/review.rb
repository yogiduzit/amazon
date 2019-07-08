class Review < ApplicationRecord

  belongs_to :product
  belongs_to :user
  
  validates(:rating, 
    numericality: {
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 5
    },
    presence: true
  )
end
