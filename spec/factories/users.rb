FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { "1a#{Faker::Internet.password(min_length: 4)}" }
    password_confirmation { password }
    last_name             { person.last.kanji }
    first_name            { person.first.kanji }
    last_name_reading     { person.last.katakana }
    first_name_reading    { person.first.katakana }
    birth_date            { Faker::Date.between(from: '1930-01-01', to: '2017-12-31') }
  end
end
