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
  #   root 'items#top'
  #   resources :items, only: [:show, :index]
  #   get 'about' => 'items#about'
  # end


#cart_items
scope module: :public do
  root to: 'homes#top'
  resources :cart_items, only: [:index, :update, :destroy, :destroy_all, :create]
end

#admin
namespace :admin do
  root :to =>"homes#top"
end

end
