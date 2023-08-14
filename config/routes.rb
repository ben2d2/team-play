Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'users/dashboard#index'

  namespace :users do
    resources :dashboard, only: %w[index]
    resources :events, only: %w[index show] do
      resources :leaderboard, only: %w[index]
      resources :scorecard, only: %w[show update]
    end
  end
end