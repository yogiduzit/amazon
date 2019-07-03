class Product < ApplicationRecord

  # Addding validation to prevent any unwanted data values
  validates(:title,
    presence: true,
    uniqueness: { case_sensitive: false }
  )

  validates(:price,
    numericality: { 
      greater_than: 0,
      less_than: 100
    }
  )
  
  validates(:description,
    presence: true,
    length: { minimum: 10 }
  )




  
  scope(:search, -> (name) {
    where("title ILIKE ? OR description ILIKE ?", "%#{name}%", "%#{name}%")
  })

  scope(:find_within_price_range, -> {
    where("price > ? AND price < ?", 100, 300).order('title').limit(10)
  })


  before_validation :capitalize_title
  before_validation :set_default_price
  before_validation :set_sale_price

  validate :no_reserved_words
  validate :sale_price_check

  before_destroy :destroy_product

  def self.sort_and_filter(search_term, column, current_page, per_page_count)
    self.search(search_term).order(column).limit(per_page_count).offset((current_page - 1) * per_page_count)
  end

  def hit_it_up
    hit_count += 1
  end

  private 
    def no_reserved_words
      if title.downcase.include?("apple") || title.downcase.include?("microsoft")||
         title.downcase.include?("sony")
        self.errors.add(:title, "must not contain reserved words")
      end
    end

    def sale_price_check
      if sale_price > price
        # self.errors.add(:sale_price, "must be less than price")
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
        self.sale_price = price
      end
    end

    def destroy_product
      puts "Product is about to be destroyed"
    end

end
