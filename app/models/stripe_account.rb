class StripeAccount

  attr_accessor :affiliate, :tos_checked, :request_ip

  def initialize(affiliate, tos_checked: false, request_ip: nil, account: nil)
    @affiliate = affiliate
    @tos_checked = tos_checked
    @request_ip = request_ip
    @account = account
  end

  def account
    @account ||= begin
                   if affiliate.stripe_id.blank?
                     create_account
                   else
                     retrieve_account
                   end
                 end
  end

  def update(values)
    update_from_hash(account, values)
    @account = account.save
    update_affiliate_verification
  end

  def update_affiliate_verification
    Affiliate.transaction do
      affiliate.update(
        stripe_charges_enabled: account.charges_enabled,
        stripe_payouts_enabled: account.payouts_enabled,
        stripe_disabled_reason: account.requirements.disabled_reason,
        stripe_validation_due_by: account.requirements.current_deadline,
        verification_needed: account.requirements.currently_due)
    end
  end

  private

  def create_account
    account_params = { country: affiliate.country, type: "custom",
                       requested_capabilities: ['card_payments', 'transfers'] }

    if tos_checked
      account_params[:tos_acceptance] = { date: Time.now.to_i, ip: request_ip }
    end

    Stripe::Account.create(account_params)
  end

  def retrieve_account
    Stripe::Account.retrieve(affiliate.stripe_id)
  end

  def update_from_hash(object, values)
    values.each do |key, value|
      if value.is_a?(Hash)
        if sub_object = object.try(key.to_sym)
          update_from_hash(sub_object, value)
        end
      elsif value.present?
        object.send(:"#{key}=", value)
      end
    end
  end
end
