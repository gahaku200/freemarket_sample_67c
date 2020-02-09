Rails.application.routes.draw do
  get 'buys/index'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  root "products#index"
  resources :products, only: [:index, :new, :create] do
    collection do
      get 'category_children' 
      get 'category_grandchildren'
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end

  get '/mypage', to: 'mypage#index'
  get '/mypage/card', to: 'mypage#card'
  get '/mypage/card/credit', to: 'mypage#credit'
  get '/mypage/logout', to: 'mypage#logout'
end