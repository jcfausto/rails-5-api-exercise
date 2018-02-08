Rails.application.routes.draw do
  # resource routes
  resources :todos do
    resources :items
  end

  # non-resource routes
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
