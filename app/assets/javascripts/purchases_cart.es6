class PaymentFormHandler {
  constructor() {
    this.checkoutForm = new CheckoutForm()
    this.initSubmitHandler()
    this.initPaymentTypeHandler()
  }

  initSubmitHandler() {
    this.checkoutForm.form().submit((event) => {
      if (!this.checkoutForm.isPaypal()) {
        this.handleSubmit(event)
      }
    })
  }

  initPaymentTypeHandler() {
    this.checkoutForm.paymentTypeRadio().click(() => {
      console.log("clicked!")
      this.checkoutForm.setCreditCardVisibility()
    })
  }

  handleSubmit(event) {
    event.preventDefault()
    if (this.checkoutForm.isButtonDisabled()) { return false }
    this.checkoutForm.disableButton()
    Stripe.card.createToken(this.checkoutForm.form(), TokenHandler.handle)
    return false
  }
}

class CheckoutForm {

  form() { return $("#payment-form") }

  button() { return this.form().find(".btn") }

  disableButton() { this.button().prop("disabled", true) }

  isButtonDisabled() { return this.button().prop("disabled") }

  submit() { this.form().get(0).submit() }

  appendHidden(name, value) {
    const field = $("<input>")
      .attr("type", "hidden")
      .attr("name", name)
      .val(value)
    this.form().append(field)
  }

  paymentTypeRadio() { return $(".payment-type-radio") }

  selectedPaymentType() { return $("input[name=payment_type]:checked").val() }

  creditCardForm() { return $("#credit-card-info") }

  isPayPal() { return this.selectedPaymentType() === "paypal" }

  setCreditCardVisibility() {
    this.creditCardForm().toggleClass("hidden", this.isPayPal())
  }
}

class TokenHandler {

  static handle(status, response) {
    console.log("status", status)
    console.log("response", response)
    new TokenHandler(status, response).handle()
  }

  constructor(status, response) {
    this.checkoutForm = new CheckoutForm()
    this.status = status
    this.response = response
  }

  handle() {
    console.log("inside handle()")
    this.checkoutForm.appendHidden("stripe_token", this.response.id)
    this.checkoutForm.submit()
  }
}

$(() => new PaymentFormHandler())

