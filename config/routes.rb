Rails.application.routes.draw do
  root 'public#index'
  resources :lawyers
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
