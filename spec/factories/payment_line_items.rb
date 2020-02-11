FactoryBot.define do
  factory :payment_line_item do
    payment { nil }
    buyable { nil }
    price { "" }
  end
end
