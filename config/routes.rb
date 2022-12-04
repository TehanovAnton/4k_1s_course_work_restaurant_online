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
      get :can_create, to: 'restaurants#can_create?'
    end

    member do
      get :can_update, to: 'restaurants#can_update?'
    end
  end
end
