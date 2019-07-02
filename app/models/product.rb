class Product < ApplicationRecord

  # Addding validation to prevent any unwanted data values
  validates(:title,
    presence: true,
    uniqueness: { case_sensitive: false }
  )

  validates(:price,
    numericality: { greater_than: 0}
  )
  
  validates(:description,
    presence: true,
    length: { minimum: 10 }
  )



  validate :no_reserved_words
  
  scope(:search, -> (name) {
    where("title ILIKE ? OR description ILIKE ?", "%#{name}%", "%#{name}%")
  })


  before_validation :capitalize_title
  before_validation :set_default_price
  before_validation :sale_price_check

  before_save :set_sale_price

  private 
    def no_reserved_words
      if title.downcase.include?("apple") || title.downcase.include?("microsoft")||
         title.downcase.include?("sony")
        self.errors.add(:title, "must not contain reserved words")
      end
    end

    def sale_price_check
      if sale_price > price
        self.errors.add(:sale_price, "must be less than price")
      end
    end

    def capitalize_title
      self.title = self.title.capitalize
    end

    def set_default_price
      if price.nil?
        self.price = 1.0;
      end
    end

    def set_sale_price
      if sale_price.nil?
        sale_price = price
      end
    end
end
