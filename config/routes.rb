Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'overrides/registrations'
  }

  resources :restaurants, :menus, :dishes, :orders, :reservations

  resources :users do
    resources :orders
  end

  resources :restaurants do
    resources :menus
  end
end
