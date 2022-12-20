Rails.application.routes.draw do
  devise_for :users
  resources :items do
    member do
      resources :orders, only: [:index, :create]
    end
  end
  root to: 'items#index'
end
