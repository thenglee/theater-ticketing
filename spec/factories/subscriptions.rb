FactoryBot.define do
  factory :subscription do
    user { nil }
    plan { nil }
    start_date { "2020-03-02" }
    end_date { "2020-03-02" }
    status { 1 }
    payment_method { "MyString" }
    remote_id { "MyString" }
  end
end
