class Review < ApplicationRecord

  belongs_to :product
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :votes, dependent: :destroy

  has_many :reviewers, through: :likes, source: :user
  has_many :voters, through: :votes, source: :user
  
  validates(:rating, 
    numericality: {
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 5
    },
    presence: true
  )
end
