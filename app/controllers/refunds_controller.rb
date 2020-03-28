class RefundsController < ApplicationController

  VALID_REFUNDABLES = %w(Payment PaymentLineItem).freeze

  def create
    load_refundable
    authorize(@refundable, :refund?)
    workflow = PreparesStripeRefund.new(
      refundable: @refundable,
      administrator: current_user,
      refund_amount_cents: @refundable.price_cents)
    workflow.run
    flash[:alert] = workflow.error || "Refund submitted"
    redirect_to redirect_path
  end

  private

  def load_refundable
    raise "bad refundable class" unless params[:type].in?(VALID_REFUNDABLES)
    @refundable = params[:type].constantize.find(params[:id])
  end

  def redirect_path
    if params[:type] == "Payment"
      admin_payments_path
    else
      admin_payment_line_items_path
    end
  end
end
