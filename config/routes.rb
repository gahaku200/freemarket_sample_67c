Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  root "products#index"
  resources :products, only: [:index, :new, :create, :show, :edit, :update] do
    collection do
      get :select_registrations
      get 'category_children' 
      get 'category_grandchildren'
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'buy'
    end
    member do
    get 'category_children' 
    get 'category_grandchildren'
    get 'get_category_children', defaults: { format: 'json' }
    get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end

  get '/mypage', to: 'mypage#index'
  get '/mypage/card', to: 'mypage#card'
  get '/mypage/logout', to: 'mypage#logout'

  resources :cards, only: [:index,:new,:create, :destroy] do
    collection do
      get 'done', to: 'cards#done'
      get 'completed', to: 'cards#completed'
    end
  end

end