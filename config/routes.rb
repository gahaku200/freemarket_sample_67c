Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  root "products#index"
  resources :products, only: [:index, :new, :create, :show] do
    collection do
      get :select_registrations
      get 'category_children' 
      get 'category_grandchildren'
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end

  get '/mypage', to: 'mypage#index'
  get '/mypage/card', to: 'mypage#card'
  get '/mypage/logout', to: 'mypage#logout'

  resources :buys, only: [:new] do
    member do
      get 'index', to: 'buys#index'
      post 'pay', to: 'buys#pay'
      get 'done', to: 'buys#done'
    end
  end

  resources :cards, only: [:new, :show, :destroy] do
    collection do
      post 'show', to: 'cards#show'
      post 'pay', to: 'cards#pay'
    end
  end

end