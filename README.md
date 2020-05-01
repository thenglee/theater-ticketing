## Snow Globe Theatre Ticketing App
Based on [Take My Money: Accepting Payments on the Web by Noel Rappin](https://pragprog.com/book/nrwebpay/take-my-money) book (Pragmatic Bookshelf)


***


### 1 Features at a glance
#### For customers
  - Purchase tickets with credit card via stripe or paypal
  - Subscriptions plans (via stripe payment)
  - Discount codes
  - Shipping options
  - Processing fee, shipping fee
  - Participate as affiliates/third-party sales (powered backend via [Stripe Connect](https://stripe.com/en-sg/connect))
#### For administrators
  - Admin login with 2FA
  - Admin Dashboard (content management, inventory, discount codes, etc)
  - Purchase tickets on behalf of customers via:
    - Cash (e.g. at ticket office)
    - Invoice/Purchase Order (e.g. bulk purchase)
  - Make refunds on entire order or individual order item
  - Reports
    - Activeadmin reports
    - Customised reports (daily revenue, etc)
  - User simulation
#### Others
  - Tax calculation via TaxCloud (USA only)
  - Stripe webhooks

***


### 2 Packages and version
 - ruby: 2.6.3
 - rails: ~ 6.0.0
 - Database: [pg](https://github.com/ged/ruby-pg) (PostgreSQL)
 - Currency: [money-rails](https://github.com/RubyMoney/money-rails)
 - Payments:
     - [stripe](https://github.com/stripe/stripe-ruby)
     - [paypal-sdk-rest](https://github.com/paypal/PayPal-Ruby-SDK)
 - Taxes: [tax_cloud](https://github.com/drewtempelmeyer/tax_cloud) (USA only)
 - Authentication:
    - [devise](https://github.com/heartcombo/devise)
    - [authy](https://github.com/twilio/authy-ruby) (2FA)
 - Authorization and roles: [pundit](https://github.com/varvet/pundit)
 - Job: [delayed_job](https://github.com/collectiveidea/delayed_job)
 - Tests: rspec, capybara, vcr, factorybot
 - Admin: activeadmin
 - Assets: slim, jQuery, ES6, sprockets, babel-transpiler
 - Track changes audit: [paper_trail](https://github.com/paper-trail-gem/paper_trail)
 - Exceptions tracking & logging: [rollbar](https://github.com/rollbar/rollbar-gem)

***

### 3 Setup
  - Install packages: `bundle`
  - Create database: `rails db:create`
  - Run database migrations: `rails db:migrate`
  - Populate your `secrets.yml` file for various API keys, etc
  - Run server: `rails s`
  - Run jobs: `rake jobs:work`
  - Run tests: `rspec spec/`
  - Run rake task to create `plans` for subscriptions: `rake theater:create_plans`

