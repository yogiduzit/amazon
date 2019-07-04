# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Review.delete_all
Product.delete_all

NUM_PRODUCTS = 10000;

NUM_PRODUCTS.times do 
  created_at = Faker::Date.backward(365 * 5)
  price = rand(100)
  sale_price = rand(price)

  product = Product.create(
    title: Faker::ElectricalComponents.active,
    description: Faker::GreekPhilosophers.quote,
    price: price,
    sale_price: sale_price,
    hit_count: 0
  )
  if product.valid?
    product.reviews = rand(0..10).times.map do
      Review.new(
        body: Faker::GreekPhilosophers.quote,
        rating: rand(1..5)
        )
      end
  end
end
  products = Product.all

  puts Cowsay.say("Generated #{products.count} products", :frogs)



