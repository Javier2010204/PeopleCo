Rails.application.routes.draw do

  	get 'search/create'
  	get 'search/buscador', as: :search
 	devise_for :users
 	resources :usuarios, as: :users, only: [:show, :update, :edit, :index, :new, :create]
	resources :friendships, only:[:create, :index, :update]
	get "dashboard", to: "home#dashboard"

	authenticated :user do
		root 'home#index', as: :authenticated_root
	end

	resources :posts do
		resources :comments
	end

	unauthenticated :user do
		root 'home#unregistered', as: :unauthenticated_root
	end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
