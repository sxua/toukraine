Toukraine::Application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config
  
  scope "(:locale)", locale: /en|ru/ do
    root to: 'home#index'
    resources :places
    resources :promotions
    resources :pages
    resources :news
  end
end