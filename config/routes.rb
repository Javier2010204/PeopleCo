Rails.application.routes.draw do

 	devise_for :users

 	resources :usuarios, as: :users, only: [:show, :update, :edit]

	authenticated :user do
		root 'home#index', as: :authenticated_root
		resources :posts do
			resources :comments
		end
	end

	unauthenticated :user do
		root 'home#unregistered', as: :unauthenticated_root
	end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
