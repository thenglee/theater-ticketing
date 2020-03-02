class PreExistingPaymentException < StandardError

  attr_accessor :payment

  def initialize(payment, message = nil)
    super(message)
    @payment = payment
  end
end
