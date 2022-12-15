Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'overrides/registrations'
  }

  resources :users, shallow: true do
    resources :orders do
      collection do
        get :can_create, to: 'orders#can_create?'
        get :can_index, to: 'orders#can_index?'
      end

      member do
        get :can_update, to: 'orders#can_update?'
        get :can_destroy, to: 'orders#can_destroy?'

        put :cancel, to: 'orders#cancel'
      end
    end

    resources :reservations

    collection do
      get :can_create, to: 'users#can_create?'
    end

    member do
      get :can_update, to: 'users#can_update?'
      get :can_destroy, to: 'users#can_destroy?'
    end
  end

  resources :restaurants do
    resources :menus, shallow: true do
      resources :dishes, shallow: true do

        collection do
          get :can_create, to: 'dishes#can_create?'
        end

        member do
          get :can_update, to: 'dishes#can_update?'
          get :can_destroy, to: 'dishes#can_destroy?'
        end
      end

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
