FactoryBot.define do
  factory :discount_code do
    code { "MyString" }
    percentage { 1 }
    description { "MyText" }
    minimum_amount { 0 }
    maximum_discount { 0 }
    max_uses { 1 }
  end
end
