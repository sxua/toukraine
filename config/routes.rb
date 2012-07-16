Toukraine::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  scope "(:locale)", locale: /en|ru|ua/ do
    root to: 'home#index'
    get '/switch_locale', to: 'redirect#switch_locale', as: :switch_locale
    get '/regions/:id/hotels(/sort/:column::dir)(/page/:page)', to: 'regions#hotels', as: :hotels_region
    get '/regions/:id(/sort/:column::dir)(/page/:page)', to: 'regions#show', as: :tours_region
    get '/hotels/:city_id/:id', to: 'hotels#show', as: :hotel_city
    get '/tours/:tour_type_id/:id', to: 'tours#show', as: :tour
    get '/tours/:id(/sort/:column::dir)(/page/:page)', to: 'tour_types#show', as: :tour_type
    post '/orders/relatives/:relative_type/:city_id', to: 'orders#relatives', as: :orders_relatives
    post '/orders/cities/:relative_type', to: 'orders#cities', as: :orders_cities
    resources :hotels, only: [:show]
    resources :pages, only: [:show]
    resources :news, only: [:index, :show]
    resources :regions, only: [:index]
    resources :sights, only: [:index, :show]
    resources :orders, only: [:new, :create]
  end
end