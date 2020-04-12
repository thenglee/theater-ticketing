FactoryBot.define do
  factory :day_revenue do
    day { "2020-04-11" }
    ticket_count { 1 }
    price { "" }
    discounts { "" }
  end
end
