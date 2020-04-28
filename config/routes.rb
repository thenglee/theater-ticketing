Rails.application.routes.draw do

  ActiveAdmin.routes(self)

  root to: "visitors#index"

  devise_for :users, controllers: { sessions: "users/sessions" }
  devise_scope :user do
    post "users/sessions/verify" => "Users::SessionsController"
  end

  resources :events

  resource :shopping_cart
  resource :subscription_cart

  resource :user_simulation, only: %i(create destroy)
  resource :daily_revenue_report

  resources :payments
  resources :users
  resources :plans
  resources :subscriptions
  resources :refunds
  resources :discount_codes
  resources :addresses
  resources :affiliates

  get "paypal/approved", to: "pay_pal_payments#approved"
  post "stripe/webhook", to: "stripe_webhook#action"
end
