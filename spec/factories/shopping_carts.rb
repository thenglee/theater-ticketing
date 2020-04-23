FactoryBot.define do
  factory :shopping_cart do
    user { nil }
    address { nil }
    shipping_method { 0 }
    discount_code_id { nil }
  end
end
