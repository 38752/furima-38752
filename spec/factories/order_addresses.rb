FactoryBot.define do
  factory :order_address do
    token         { "tok_abcdefghijk00000000000000000" }
    post_code     { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture_id { Faker::Number.within(range: 2..48) }
    city          { Faker::Address.city }
    address       { Faker::Address.secondary_address }
    apartment     { Faker::Address.mail_box }
    phone_number  { Faker::Number.leading_zero_number(digits: 10) }
  end
end
