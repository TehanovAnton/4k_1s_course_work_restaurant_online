Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'overrides/registrations'
  }

  resources :dishes, :orders, :reservations

  resources :users do
    resources :orders

    collection do
      get :can_create, to: 'users#can_create?'
    end

    member do
      get :can_update, to: 'users#can_update?'
      get :can_destroy, to: 'users#can_destroy?'
    end
  end

  resources :restaurants do
    resources :menus do
      collection do
        get :can_create, to: 'menus#can_create?'
      end

      member do
        get :can_update, to: 'menus#can_update?'
        get :can_destroy, to: 'menus#can_destroy?'
      end
    end

    collection do
      get :can_create, to: 'restaurants#can_create?'
    end

    member do
      get :can_update, to: 'restaurants#can_update?'
      get :can_destroy, to: 'restaurants#can_destroy?'
    end
  end
end
