Chicagofood::Application.routes.draw do

  resources :neighborhoods
  resources :venuetypes
  resources :ratings
  resources :comments
  resources :tries
  resources :users, :path => 'u' do
  	resources :comments
  	resources :ratings
  	resources :tries
  end

  resources :venues do
  	resources :comments
  	resources :ratings
  	resources :tries
  	get 'rating_average'
  end

  devise_for :users, path_names: { sign_up: 'register' }, :controllers => { :registrations => 'registrations' }

	get 'map' => 'welcome#map'

	root "welcome#index"

end
