class NewsArticle < ApplicationRecord

  

  validates(:title, presence: true, uniqueness: true)
  validates(:description, presence: true)
  validate :compare_publish_date

  belongs_to :user

  def titleized
    title.upcase!
  end

  def publish
    published_at = Time.now
  end

  def set_created_at
    created_at = Time.now
  end

  def compare_publish_date
    return unless published_at.present?
    if published_at < created_at
      
      errors.messages.add(:published_at, "Publish date cannot be less than creation date")

    end
  end

  before_validation :set_created_at
  after_save :publish
  after_save :titleized
  

end
