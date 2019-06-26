Rails.application.routes.draw do
  scope '/api' do
    # sessions routes
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'

    resources :restaurants, only: %I[index show]
    resources :orders, only: %I[index show create update]
  end
end
