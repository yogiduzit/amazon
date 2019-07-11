FactoryBot.define do
  factory :news_article do
    title {Faker::Job.title}
    description {"fskdjfnsdfsdfjskfnsdv dsknslfksd, dsvdsflnsdwqwdwnkjfewjknfwfnejkwfnwkfnewjknfewjkf"}
    association(:user, factory: :user)
  end
end
