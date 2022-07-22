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

#cart_items
scope module: :public do
  resources :cart_items, only: [:index, :update, :destroy, :destroy_all, :create]
end
end
