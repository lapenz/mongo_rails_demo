FactoryBot.define do
  factory :post do
    title { Faker::Name.name }
    body { Faker::Lorem.paragraph }
    user
  end


end