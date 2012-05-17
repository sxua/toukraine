Toukraine::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  scope "(:locale)", locale: /en|ru/ do
    root to: 'home#index'
    resources :hotels
    resources :promotions
    resources :pages
    resources :news
    resources :regions
  end
end