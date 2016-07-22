Rails.application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  
  devise_for :users
    
  resources :apps
  resources :users
  
  match '/store-unavailable' => 'home#store_off', :via => :get, as: :store_off
  root "home#index"
end
