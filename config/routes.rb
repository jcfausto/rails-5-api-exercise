Rails.application.routes.draw do

  # Namespaced API without adding version number to the URI
  # The api version should be informed in the headers.
  # Default to v1 case the api version is not specified.
  # IMPORTANT: Alwas leavee the default version as the last one. Put all other
  # verions above the default one.
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    # resource routes
    resources :todos do
      resources :items
    end
  end

  # non-resource routes. Do not require authorization.
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  delete 'delete', to: 'users#destroy'
end
