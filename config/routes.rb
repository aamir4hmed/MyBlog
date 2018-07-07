Rails.application.routes.draw do
  resources :blogs
  resources :users


	match 'auth/:provider/callback', to: 'sessions#create', via: [:get,:post]
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
