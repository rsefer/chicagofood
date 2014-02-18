Chicagofood::Application.routes.draw do
	
  resources :neighborhoods
  resources :venuetypes
  resources :ratings
  resources :comments
  resources :users, :path => 'u' do
  	resources :to_tries
  end

  resources :venues do
  	resources :comments
  	resources :ratings
  end

  devise_for :users, path_names: { sign_up: 'register' }, :controllers => { :registrations => 'registrations' }
	
	root "welcome#index"
	
end
