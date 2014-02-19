ContactsAPI::Application.routes.draw do
  resources :users, only: [:create, :destroy, :index, :show, :update] do
    resources :contacts, only: [:index]
    member do
      get :favorites
      post :add_favorite
    end
  end

  resources :contacts, only: [:create, :destroy, :show, :update]

  resources :contact_shares, only: [:create, :destroy]

  # Doing it the hard way!
  # get '/users', to: 'users#index'
  # get '/users/new', to: 'users#new', as: 'new_user'
  # get '/users/:id/edit', to: 'users#edit', as: 'edit_user'
  # get '/users/:id', to: 'users#show', as: 'user'
  # post '/users', to: 'users#create'
  # patch '/users/:id', to: 'users#update'
  # put '/users/:id', to: 'users#update'
  # delete '/users/:id', to: 'users#destroy'
end
