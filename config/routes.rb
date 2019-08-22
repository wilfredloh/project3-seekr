Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'jobs#home'

  get '/jobs/status' => 'jobs#status', as: 'status_job'
  resources :jobs
  resources :contacts
  resources :documents


end