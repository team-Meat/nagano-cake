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
   get '/complete' => 'orders#complete' #注文完了ページ
   resources :items, only: [:show, :index]
   resources :shippings, only: [:index, :create, :edit, :update, :destroy]
   resources :cart_items, only: [:index, :update, :destroy, :destroy_all, :create]
   resources :orders, only: [:new, :show, :index, :confirm, :update, :destroy]
   post '/orders/confirm' => 'orders#confirm', as: 'orders_confirm' #購入確認画面への遷移
   get '/orders/create_order' => 'orders#create_order' #購入確定のアクション
   post '/orders/create_shipping' => 'orders#create_shipping' #情報入力画面での配送先登録用のアクション
  delete '/cart_items' => 'cart_items#destroy_all' #カートアイテムを全て削除
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
  resources :customers, only: [:show,:edit,:update,:confirm,:withdraw]
  #resources :orders, only: [:index]
  end
  get'public/customers/confirm' => 'public/customers/confirm'

  scope module: :admin do
  resources :items, only: [:show,:edit,:update,:index]
  end
   get'public/homes/top'
   get'public/homes/about'



end