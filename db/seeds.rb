# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Review.delete_all
Product.delete_all
User.delete_all

NUM_PRODUCTS = 200
NUM_USERS = 20
PASSWORD = "secret"

super_user = User.create(
  first_name: "Yogesh",
  last_name: "Verma",
  email: "itsyog35h@gmail.com",
  password: PASSWORD
)

NUM_USERS.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create(
    first_name: first_name,
    last_name: last_name,
    password: PASSWORD,
    email: "#{first_name.downcase}.#{last_name.downcase}@example.com"
  )

end
users = User.all

NUM_PRODUCTS.times do 
  created_at = Faker::Date.backward(365 * 5)
  price = rand(100)
  sale_price = rand(price)

  product = Product.create(
    title: Faker::ElectricalComponents.active,
    description: Faker::GreekPhilosophers.quote,
    price: price,
    sale_price: sale_price,
    hit_count: 0,
    user: users.sample
  )
  if product.valid?
    product.reviews = rand(0..10).times.map do
      Review.new(
        body: Faker::GreekPhilosophers.quote,
        rating: rand(1..5),
        user: users.sample
        )
      end
  end
end
  products = Product.all

  puts Cowsay.say("Generated #{products.count} products", :frogs)



