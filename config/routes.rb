# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :products, only: %i[index show new create edit update destroy]
  end
  resources :products, only: %i[index show]
  resources :cart_products, only: %i[index create destroy]
  root 'products#index'

  # ルーティングが存在しないパスへアクセスしたとき、ルートへリダイレクトする。
  # この際、'rails/active_storage'が含まれているパスはリダイレクト対象外にする
  get '*path', to: redirect('/'), constraints: ->(req) { req.path.exclude? 'rails/active_storage' }
end
