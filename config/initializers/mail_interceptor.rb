unless Rails.env.test? || Rails.env.production?
  options = { forward_emails_to: "thengleecoding@gmail.com",
              deliver_emails_to: ["thengleecoding@gmail.com"] }

  interceptor = MailInterceptor::Interceptor.new(options)

  ActionMailer::Base.register_interceptor(interceptor)

  EmailPrefixer.configure do |config|
    config.application_name = "take-my-money"
  end
end
