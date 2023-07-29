Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users do
    
  end 
end