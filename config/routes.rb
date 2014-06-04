Rsvp::Application.routes.draw do
  resources :bookings

  resources :shares

  get "mailbox", to: 'mailbox#index'
  get "upcoming", to: 'upcoming#index'
  get "following", to: 'following#index'
  get "favourite", to: 'favourite#index'
  get "dashboard", to: 'dashboard#index'
  get "schedule", to: 'schedule#index'
  get "mybookings", to: 'mybookings#index'
  get 'mailbox/:id', to: 'mailbox#show'
  match '/profile/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  
  resources :messages
  resources :views
  resources :addresses
  resources :categories
  resources :slots
  resources :rules
  resources :activities
  resources :rule_instances

  root :to => "home#index"
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }
  devise_for :merchants, :controllers => {:registrations => 'registrations'}
  devise_for :admin_users, ActiveAdmin::Devise.config  
  ActiveAdmin.routes(self)
  resources :users, :only => [:index, :show]
  resources :merchants
  mount Attachinary::Engine => "/attachinary"
end