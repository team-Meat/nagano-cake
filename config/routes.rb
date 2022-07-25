Rails.application.routes.draw do
  # 顧客用
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    root :to =>"homes#top"
    # 配送先
    resources :items, only: [:show, :index]
    resources :shippings, only: [:index, :create, :edit, :update, :destroy]
    resources :cart_items, only: [:index, :update, :destroy, :destroy_all, :create]
  end

  namespace :admin do
    root :to =>"homes#top"

    # ジャンル
    resources :genres, only: [:create, :index, :update, :edit]

    # 会員
    resources :customers, only: [:show, :index, :edit, :update, :destroy]

    # 注文
    resources :orders, only: [:show, :index, :update, :destroy]

    # 商品
    resources :items, only: [:new, :show, :create, :edit, :index, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module: :public do
    resources :customers, only: [:show,:edit,:update,:destroy,:withdraw,:create,:confirm]
    #resources :orders, only: [:index]
  end
  get 'public/customers/confirm'
  get '/public/customers/:id/unsubscribe' => 'public#customers#unsubscribe', as: 'unsubscribe'
  # 論理削除用のルーティング
  patch '/public/customers/:id/withdrawal' => 'public#customers#withdrawal', as: 'withdrawal'

  scope module: :admin do
    resources :items, only: [:show,:edit,:update,:index]
  end

  get'public/homes/top'
  get'public/homes/about'
end