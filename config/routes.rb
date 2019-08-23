Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'jobs#home'

  get '/jobs/status' => 'jobs#status', as: 'status_job'
  get '/contacts/grid' => 'contacts#grid', as: 'grid_contact'
  resources :jobs
  resources :contacts
  resources :documents
  get '/stats' => 'stats#index'
  post '/special' => 'jobs#activate_serious_mode', as: 'create_special'
  post '/special/update' => 'jobs#deactivate_serious_mode', as: 'update_special'


end