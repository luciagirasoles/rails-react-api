Rails.application.routes.draw do
  # sessions routes
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :restaurants, only: %I[index show]
  resources :orders, only: %I[index show create]
end
