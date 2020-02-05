FactoryBot.define do
  factory :user do
    nickname              {"a"}
    first_name            {"あ"}
    last_name             {"あ"}
    first_name_kana       {"あ"}
    last_name_kana        {"あ"}
    birthday_year         {"1"}
    birthday_month        {"1"}
    birthday_day          {"1"}
    email                 {"a@a.a"}
    password              {"1111111"}
    password_confirmation {"1111111"}
  end
end