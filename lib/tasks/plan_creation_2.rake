namespace :theater do
  task create_plans_1: :environment do
    plans = [
      { remote_id: "orchestra_1_monthly", product: { name: "Orchestra 1 Monthly"},
        nickname: "Orchestra 1 Monthly", price_cents: 10_000,
        interval: "month", tickets_allowed: 1, ticket_category: "Orchestra" },
      { remote_id: "balcony_1_monthly", product: { name: "Balcony 1 Monthly" },
        nickname: "Balcony 1 Monthly", price_cents: 60_000,
        interval: "month", tickets_allowed: 1, ticket_category: "Balcony" },
      { remote_id: "vip_1_monthly", product: { name: "VIP 1 Monthly" },
        nickname: "VIP 1 Monthly", price_cents: 30_000,
        interval: "month", tickets_allowed: 1, ticket_category: "VIP" }
    ]

    Plan.transaction do
      plans.each { |plan_data| CreatesPlan.new(**plan_data).run }
    end
  end
end
