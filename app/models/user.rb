class User < ApplicationRecord

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true
  validates :email, presence: true

  has_many(:products, dependent: :nullify)
  has_many(:reviews, dependent: :nullify)

  scope(:strict_search, -> (search) {
    where("first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?", 
      "#{search}", "#{search}", "#{search}")
  })

  scope(:search, -> (search) {
    where("first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?", 
      "%#{search}%", "%#{search}%", "%#{search}%")
  })

  scope(:created_after, -> (date) {
    # where(created_at: [date, Time.now])
    where("created_at > ?", date)
  })

  scope(:not_john, -> {
    where("first_name NOT ILIKE ? AND last_name NOT ILIKE ?", "john", "john")
  })

  scope(:find_within_date, -> (date1, date2) {
    where("created_at > ? AND created_at < ?", "#{date1}", "#{date2}")
  });

  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX 

end



