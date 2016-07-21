Rails.application.routes.draw do
  devise_for :users
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  
  resources :apps
  
  match '/store-unavailable' => 'home#store_off', :via => :get, as: :store_off
  root "home#index"
end
