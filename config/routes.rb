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
  post '/special/easy' => 'jobs#activate_easy_mode', as: 'create_easy'
  post '/special/hard' => 'jobs#activate_hard_mode', as: 'create_hard'
  post '/special/test' => 'jobs#activate_test_mode', as: 'create_test'
  post '/special/update' => 'jobs#deactivate_serious_mode', as: 'update_special'
  post '/special/reset' => 'jobs#reset_mode', as: 'reset_special'


end