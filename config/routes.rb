Rsvp::Application.routes.draw do

  get "terms", to: 'terms#index'
  get "client", to: 'client#index'
  get "search", to: 'search#index'
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
  get "confirmed", to: 'confirmed#index'
  get '/generator/:id/new', to: 'rules#new', :as => :generate_rule
  get '/messageclient/:id/new', to: 'messages#new', :as => :to_client
  get '/messagemerchant/:id/new', to: 'messages#new', :as => :to_merchant
  get '/location/:addid/activity/:id', to: 'activities#show', :as => :location_activity
  get '/location/:addid/merchants/:id', to: 'merchants#show', :as => :location_merchant
  get '/location/:addid/activity/:activity_id/slots', to: 'slots#index', :as => :address_slot
  match '/profile/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  
  resources :messages
  resources :likes
  resources :follows
  resources :hosts
  resources :bookings
  resources :views
  resources :categories
  resources :rules
  resources :addresses
  resources :activities, shallow: true do 
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