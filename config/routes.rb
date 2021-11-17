Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  
  resources :items do
    resources :orders, only: [:index, :create]
    # items と紐付け(商品情報にネストされる)
    # 購入ページ:index、購入処理:create
  end
end
