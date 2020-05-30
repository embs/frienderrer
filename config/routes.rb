Rails.application.routes.draw do
  resources :referrals, only: :create
  resources :users, only: :create
end
