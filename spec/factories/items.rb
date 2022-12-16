FactoryBot.define do
  factory :item do
    name                  { Faker::House.furniture }
    detail                { Faker::Lorem.paragraph }
    category_id           { Faker::Number.within(range: 2..11) }
    condition_id          { Faker::Number.within(range: 2..7) }
    delivery_charge_by_id { Faker::Number.within(range: 2..3) }
    prefecture_id         { Faker::Number.within(range: 2..48) }
    days_to_post_id       { Faker::Number.within(range: 2..4) }
    price                 { Faker::Number.within(range: 300..9999999) }

    association :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_star.png'), filename: 'test_star.png')
    end
  end
end
