class NewsArticle < ApplicationRecord

  validates(:title, presence: true, uniqueness: true)
  validates(:description, presence: true)
  validate :compare_publish_date

  def titleized
    p "Yog"
    title.upcase!
  end

  def publish
    p "Yogi"
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
