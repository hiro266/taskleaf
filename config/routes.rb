Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks, only: %i[new edit show]
end
