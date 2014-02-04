Chicagofood::Application.routes.draw do
	
  resources :venues do
  	resources :comments
  	resources :ratings
  end

  devise_for :users, path_names: { sign_up: 'register' }
	
	root "welcome#index"
	
end
