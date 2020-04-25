FactoryBot.define do
  factory :address do
    address_1 { "1061 W. Addison" }
    address_2 { "" }
    city { "Chicago" }
    state { "IL" }
    zip { "60613" }
  end
end
