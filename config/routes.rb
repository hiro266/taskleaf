Rails.application.routes.draw do
  resources :tasks, only: %i[index new edit show]
end
