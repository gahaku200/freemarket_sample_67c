FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.name }
    first_name            {"あ"}
    last_name             {"あ"}
    first_name_kana       {"あ"}
    last_name_kana        {"あ"}
    birthday_year         {Faker::Number.number}
    birthday_month        {Faker::Number.number}
    birthday_day          {Faker::Number.number}
    email                 {Faker::Internet.email}
    password              {"0000000"}
    password_confirmation {"0000000"}
  end
end