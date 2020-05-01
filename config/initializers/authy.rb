require "yaml"

Authy.api_key = Rails.env.production? ? ENV["AUTHY_KEY"] : Rails.application.secrets.authy_key
Authy.api_uri = "https://api.authy.com"
