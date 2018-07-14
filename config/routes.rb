Rails.application.routes.draw do
  root 'public#index'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
