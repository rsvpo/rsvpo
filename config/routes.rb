Rsvp::Application.routes.draw do
  resources :slots

  resources :rules
  resources :activities
  resources :rule_instances

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  devise_for :merchants, :controllers => {:registrations => 'registrations'}
  devise_for :admin_users, ActiveAdmin::Devise.config  
  ActiveAdmin.routes(self)
  resources :users, :only => [:index, :show]
  resources :merchants
  mount Attachinary::Engine => "/attachinary"
end