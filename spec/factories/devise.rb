FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password {Faker::Lorem.characters(number: 6)}

  end


end