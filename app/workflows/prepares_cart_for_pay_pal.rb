class PreparesCartForPayPal < PreparesCart
  attr_accessor :pay_pal_payment

  def update_tickets
    tickets.each(&:pending!)
  end

  def redirect_on_success_url
    pay_pal_payment.redirect_url
  end

  def payment_attributes
    super.merge(payment_method: "paypal")
  end

  def calculate_success
    @success = payment.pending?
  end

  def on_success
    @pay_pal_payment = PayPalPayment.new(payment: payment)
    response_id = pay_pal_payment.response_id
    logger.info "pay_pal_payment.pay_pal_payment.success?: #{pay_pal_payment.pay_pal_payment.success?}"
    logger.info "pay_pal_payment.pay_pal_payment.error: #{pay_pal_payment.pay_pal_payment.error}"
    logger.info "pay_pal_payment.pay_pal_payment.transactions: #{pay_pal_payment.pay_pal_payment.transactions}"
    if pay_pal_payment.pay_pal_payment.success? == false
      Rollbar.error(pay_pal_payment.pay_pal_payment.error, pay_pal_payment.pay_pal_payment.transactions)
      raise PayPalPaymentException.new
    end

    payment.update(response_id: response_id)
    payment.pending!
  end

  def on_failure
    @success = false
  end

  def payment_type
    "pay_pal"
  end
end
