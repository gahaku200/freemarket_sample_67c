FactoryBot.define do
  factory :address do
    address_first_name            {"あ"}
    address_last_name             {"あ"}
    address_first_name_kana       {"あ"}
    address_last_name_kana        {"あ"}
    zipcode               {"000-0000"}
    prefecture            {"a"}
    city                  {"a"}
    municipality          {"a"}
    address               {"a"}
  end
end