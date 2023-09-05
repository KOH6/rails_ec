# frozen_string_literal: true

Rails.application.routes.draw do
  resources :products, only: %i[index show]
  root 'products#index'

  # ルーティングが存在しないパスへアクセスしたとき、ルートへリダイレクトする。
  # この際、'rails/active_storage'が含まれているパスはリダイレクト対象外にする
  get '*path', to: redirect('/'), constraints: lambda { |req| req.path.exclude? 'rails/active_storage' }
end
