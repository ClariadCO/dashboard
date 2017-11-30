Rails.application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  
  root "home#index"
  
  devise_for :users, path_prefix: :auth
    
  resources :apps
  resources :users
  
  match '/store-unavailable' => 'home#store_off', :via => :get, as: :store_off
end
