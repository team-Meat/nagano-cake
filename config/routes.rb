Rails.application.routes.draw do

# 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope module: :public do
  resources :customers, only: [:show,:edit,:update,:destroy,:withdraw,:create]
  #resources :orders, only: [:index]
  end

  get '/pulic/customers/:id/unsubscribe' => 'public#customers#unsubscribe', as: 'unsubscribe'
  # 論理削除用のルーティング
  patch '/public/customers/:id/withdrawal' => 'public#customers#withdrawal', as: 'withdrawal'

  scope module: :admin do
  resources :items, only: [:show,:edit,:update,:index]
  end
   get'public/homes/top'
   get'public/homes/about'



end