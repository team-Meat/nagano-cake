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

# scope module: 'customers' do
# root 'items#top'
# resources :items, only: [:show, :index]
# get 'about' => 'items#about'
# end
scope module: :public do
root :to =>"homes#top"
get '/complete' => 'orders#complete' #注文完了ページ
post '/orders/confirm' => 'orders#confirm', as: 'orders_confirm' #購入確認画面への遷移
get '/orders/create_order' => 'orders#create_order' #購入確定のアクション
resources :items, only: [:show, :index]
resources :shippings, only: [:index, :create, :edit, :update, :destroy]
resources :cart_items, only: [:index, :update, :destroy, :destroy_all, :create]
resources :customers, only: [:show,:edit,:update,:destroy,:withdraw,:create,:confirm]
resources :name_addresses,only: [:show,:index,:edit,:update,:destroy,:create]
get 'searches/search'
get 'homes/about'
resources :orders, only: [:new, :show, :index, :confirm, :update, :destroy, :create]
resources :customers, only: [:show,:edit,:update,:destroy,:withdraw,:create,:confirm]
resources :name_addresses,only: [:show,:index,:edit,:update,:destroy,:create]
delete '/cart_items' => 'cart_items#destroy_all' #カートアイテムを全て削除
get 'searches/search'
get 'homes/about'
end
 get 'public/customers/:id/unsubscribe' => 'public/customers#unsubscribe', as: 'unsubscribe'
 # 論理削除用のルーティング
 patch '/public/customers/:id/withdrawal' => 'public/customers#withdrawal', as: 'withdrawal'



namespace :admin do
root :to =>"homes#top"
get'public/homes/about'

# ジャンル
resources :genres, only: [:create, :index, :update, :edit]
# 会員
resources :customers, only: [:show, :index, :edit, :update, :destroy]
# 注文
resources :orders, only: [:show, :index, :update, :destroy]
# 商品
resources :items, only: [:new, :show, :create, :edit, :index, :update]
end




end

