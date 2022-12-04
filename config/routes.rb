Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'overrides/registrations'
  }

  resources :dishes, :orders, :reservations

  resources :users do
    resources :orders
  end

  resources :restaurants do
    resources :menus

    collection do
      get :can_create, to: 'restaurants#can_create'
    end
  end
end
