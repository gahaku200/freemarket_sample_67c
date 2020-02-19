Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  root "products#index"
  
  namespace :products do
    resources :searches, only: :index
  end

  resources :products do
    collection do
      get :select_registrations
      get 'category_children' 
      get 'category_grandchildren'
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'search'
    end
    resources :buys, only: [:index] do
      collection do
        post 'pay', to: 'buys#pay'
        get 'done', to: 'buys#done'
      end
    end
    member do
    get 'category_children' 
    get 'category_grandchildren'
    get 'get_category_children', defaults: { format: 'json' }
    get 'get_category_grandchildren', defaults: { format: 'json' }
    end

    resources :comments, only: [:create]

  end

  resources :mypage, only: [:index] do
    collection do
      get 'card', to: 'mypage#card'
      get 'logout', to: 'mypage#logout'
    end
  end

  resources :cards, only: [:index,:new,:create, :destroy] do
    collection do
      get 'done', to: 'cards#done'
    end
  end

end