Rails.application.routes.draw do
  resources :referrals, only: :create
end
