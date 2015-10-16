Chicagofood::Application.routes.draw do

  resources :neighborhoods
  resources :venuetypes
  resources :ratings
  resources :comments
  resources :tries
  resources :item_ratings
  resources :eats

  resources :users, :path => 'u' do
  	resources :comments
  	resources :ratings
  	resources :tries
    resources :item_ratings
    resources :eats
    resources :lists do
      resources :list_items
    end
  end

  resources :venues do
  	resources :comments
  	resources :ratings
  	resources :tries
    resources :items
    resources :eats
  	get 'rating_average'
  end

  devise_for :users, path_names: { sign_up: 'register' }, :controllers => { :registrations => 'registrations' }

	get 'map' => 'welcome#map'
  get 'about' => 'welcome#about'
  get 'venues_controller/update_item_rating_display', to: 'venues#update_item_rating_display'

	root "welcome#index"

end
