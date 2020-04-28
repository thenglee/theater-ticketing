git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.0'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3', '~> 1.4'
gem "pg"
# Use Puma as the app server
gem 'puma', '~> 3.11'
gem 'jquery-rails'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5'
gem 'bootstrap-sass'
gem 'sassc-rails', '>= 2.1.0'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
# gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem "devise"
gem "authy"

gem 'slim'
gem "sprockets"
gem "babel-transpiler"
gem 'sprockets-es6'

gem "dotenv-rails"
gem "stripe"
gem "paypal-sdk-rest"

gem "delayed_job_active_record"
gem "daemons"

gem "activeadmin"
gem "active_admin_theme"
gem 'cancancan'
gem 'draper'
gem 'pundit'

gem 'rollbar'
gem "paper_trail"

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false
gem 'money-rails'

gem "city-state"
gem "tax_cloud"


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 4.0.0.beta4'
  gem "factory_bot_rails"
  gem 'brakeman', require: false
end

group :development, :staging do
  gem "mail_interceptor"
  gem "email_prefixer"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'bundler-audit'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'capybara-screenshot'
  gem 'database_cleaner'
  gem 'fake_stripe'
  gem 'selenium-webdriver'
  gem 'poltergeist'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  gem "vcr"
  gem "webmock"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
