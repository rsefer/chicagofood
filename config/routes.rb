Chicagofood::Application.routes.draw do

  resources :item_ratings

  resources :neighborhoods
  resources :venuetypes
  resources :ratings
  resources :comments
  resources :tries
  resources :users, :path => 'u' do
  	resources :comments
  	resources :ratings
  	resources :tries
    resources :item_ratings
  end

  resources :venues do
  	resources :comments
  	resources :ratings
  	resources :tries
    resources :items
  	get 'rating_average'
  end

  devise_for :users, path_names: { sign_up: 'register' }, :controllers => { :registrations => 'registrations' }

	get 'map' => 'welcome#map'

	root "welcome#index"

end
