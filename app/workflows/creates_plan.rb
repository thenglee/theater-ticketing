class CreatesPlan

  attr_accessor :remote_id, :product, :nickname, :price_cents, :interval, :tickets_allowed, :ticket_category, :plan

  def initialize(remote_id:, product:, nickname:, price_cents:, interval:, tickets_allowed:, ticket_category:)
    @remote_id = remote_id
    @product = product
    @nickname = nickname
    @price_cents = price_cents
    @interval = interval
    @tickets_allowed = tickets_allowed
    @ticket_category = ticket_category
  end

  def run
    remote_plan = Stripe::Plan.create(
      id: remote_id, product: product, nickname: nickname, amount: price_cents, currency: "usd", interval: interval)

    self.plan = Plan.find_or_create_by(
      remote_id: remote_plan.id, name: nickname, price_cents: price_cents, interval: interval, interval_count: 1,
      tickets_allowed: tickets_allowed, ticket_category: ticket_category, status: :active)
  end
end
