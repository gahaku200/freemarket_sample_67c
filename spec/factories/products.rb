FactoryBot.define do
  factory :product do
    sequence(:name)                   {Faker::Book.title}
    sequence(:price)                  {Faker::Number.within(range: 300..999999)}
    sequence(:description)            {Faker::Lorem.sentence}
    status_id                         {1}
    delivery_charge_id                {1}
    delivery_days_id                  {1}
    ship_from_id                      {Faker::Number.within(range: 1..48)}
  end
end