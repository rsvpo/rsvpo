Rsvp::Application.routes.draw do
  resources :hosts

  resources :bookings

  resources :shares

  get "mailbox", to: 'mailbox#index'
  get "inbox", to: 'inbox#index'
  get "upcoming", to: 'upcoming#index'
  get "following", to: 'following#index'
  get "favourite", to: 'favourite#index'
  get "dashboard", to: 'dashboard#index'
  get "schedule", to: 'schedule#index'
  get "mybookings", to: 'mybookings#index'
  get "myactivities", to: 'myactivities#index'
  get "pending", to: 'pending#index'
  get "confirmed", to: 'confirmed#index'
  match '/profile/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  
  resources :messages
  resources :views
  resources :addresses
  resources :categories
  resources :rules
  resources :activities do
    resources :slots
  end
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