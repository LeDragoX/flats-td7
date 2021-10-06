Rails.application.routes.draw do
  devise_for :users, path: 'users'
  devise_for :property_owners, path: 'property_owners'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  resources :properties, only: %i[show, new, create] do
    get 'my_properties', on: :collection
    resources :property_reservations, only: %i[create show], shallow: true
  end
  resources :property_types, only: [:show, :new, :create]
end
