class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :review
  
  validates :vote_type, presence: true
  validate :validate_type
  validates :review_id, uniqueness: {scope: :user_id}

  def validate_type
    if !(vote_type == "up" || vote_type == "down")
      errors.add(:type, "is not of correct format")
    end
  end

end
