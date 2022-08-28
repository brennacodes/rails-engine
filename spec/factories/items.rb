FactoryBot.define do
  factory :item do
    name { Faker::Coffee.blend_name }
    description { Faker::Coffee.notes }
    unit_price { Faker::Number.decimal(l_digits: rand(1..2), r_digits: 2) }
    merchant_id { Merchant.last.id }
  end
end
