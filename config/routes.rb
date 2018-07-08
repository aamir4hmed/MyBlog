class AuthConstraint
  def matches?(request)
    request.session['user_id'].present?
  end
end

Rails.application.routes.draw do

  use_doorkeeper
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/user/:id/verify", to: 'users#verify', as: 'user_verify'
  post "/user/:id/verify", to: 'users#verify', as: 'user_verify_code'
  post "/user/:id/resend", to: 'users#resend', as: 'user_resend'
  get "/user/:id/send_code", to: 'users#send_code', as: 'user_send_code'
  constraints(AuthConstraint.new) do
    resources :blogs
    root 'blogs#index', via: :get
    match "/blog/:id/verify_post", to: 'blogs#verify_post', as: 'blog_verify', via: [:get, :post]
    match "/blog/:id/verify_code", to: 'blogs#verify_code', as: 'blog_verify_code', via: [:get, :post]
    match "/blog/:id/send_code", to: 'blogs#send_code', as: 'blog_send_code', via: [:get, :post]
    post "/blog/:id/resend", to: 'blogs#resend', as: 'blog_resend'
    match "/my_blog_list", to: 'blogs#my_blog_list', as: 'my_blog_list', via: [:get]
  end

  resources :users, only: [:new, :create, :index, :show]
  root 'blogs#index', via: :get
  match "/sessions/new", to: 'sessions#new',as: "/login_user", via: [:get,:post]


    match 'auth/:provider/callback', to: 'sessions#create', via: [:get,:post]
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:new,:create,:index, :destroy]
 
end
