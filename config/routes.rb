require 'sidekiq/web'

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'overrides/registrations'
  }

  mount ActionCable.server => '/cable'

  mount Sidekiq::Web => '/sidekiq'

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
        post :post_rating, to: 'orders#post_rating'
        delete :destroy_rating, to: 'orders#destroy_rating'

        get :order_messages, to: 'orders#order_messages'
        post :post_message, to: 'orders#post_message'
        delete :delete_message, to: 'orders#delete_message'
      end

      resources :ratings
    end

    resources :reservations

    collection do
      get :can_create, to: 'users#can_create?'
      get :show_by_email, to: 'users#show_by_email'
      get :send_reset_password, to: 'users#send_reset_password'
    end

    member do
      get :can_update, to: 'users#can_update?'
      get :can_destroy, to: 'users#can_destroy?'
    end
  end

  resources :restaurants do
    resources :orders

    resources :menus, shallow: true do
      resources :dishes, shallow: true do
        collection do
          get :can_create, to: 'dishes#can_create?'
        end

        member do
          get :can_update, to: 'dishes#can_update?'
          get :can_destroy, to: 'dishes#can_destroy?'
          put :attache_image, to: 'dishes#attache_image'
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
      get :search, to: 'restaurants#search'
    end

    member do
      get :can_update, to: 'restaurants#can_update?'
      get :can_destroy, to: 'restaurants#can_destroy?'

      get :restaurant_messages, to: 'restaurants#restaurant_messages'
      post :post_message, to: 'restaurants#post_message'
      delete :delete_message, to: 'restaurants#delete_message'
    end
  end

  namespace :cooks do
    resources :restaurants, only: [] do
      resources :orders, only: [:index]
    end

    put 'order_states/:id/transition', to: 'order_states#transition'
  end

  namespace 'restaurants_teams' do
    resources :restaurants, only: [] do
      member do
        get :team, to: 'restaurants_teams#team'
        post :create_cook, to: 'restaurants_teams#create_cook'
      end
    end
  end
end
