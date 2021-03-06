class CancelsStripeSubscription

  attr_accessor :subscription, :user

  def initializer(subscription_id:, user:)
    @subscription_id = subscription_id
    @user = user
    @success = false
  end

  def subscription
    @subscription ||= Subsciption.find(subscription_id)
  end

  def customer
    @customer ||= StripeCustomer.new(user)
  end

  def remote_subscription
    @remote_subscription ||=
      customer.subscriptions.retrieve(subscription.remote_id)
  end

  def user_is_subscribed?
    subscription_id && user.subscriptions.map(&:id).include?(subscription_id)
  end

  def run
    return unless user_is_subscribed?
    return if customer.nil? || remote_subscription.nil?
    remote_subscription.delete
    subscription.canceled!
  end
end
