class ProductSerializer < ActiveModel::Serializer
  attributes(:title, :description, :price, :sale_price, :hit_count, :created_at)
  belongs_to(:user, key: :seller)
  has_many(:reviews)

  class ReviewSerializer < ActiveModel::Serializer
    attributes(:id, :body, :rating)
  end
end
