class NotifiesTaxCloud

  attr_accessor :payment

  def initialize(payment)
    @payment = payment
    @success = false
  end

  def tax_calculator
    @tax_calculator ||= payment.price_calculator.tax_calculator
  end

  def valid_amount?
    tax_calculator.tax_amount == Money.new(payment.paid_taxes)
  end

  def run
    if payment.payment_method != "paypal" && valid_amount?
      result = tax_calculator.authorized_with_capture(payment.reference)
      @success = (result == "OK")
    else
      raise TaxValidityException.new(payment_id: payment.id, expected_taxes: tax_calculator.tax_amount,
                                     paid_taxes: Money.new(payment.paid_taxes))
    end
  end
end
