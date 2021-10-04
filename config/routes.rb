Rails.application.routes.draw do
  devise_for :property_owners
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  resources :properties, only: [:show, :new, :create] do
    get 'my_properties', on: :collection
  end
  resources :property_types, only: [:show, :new, :create]
end
