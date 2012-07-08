Toukraine::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  scope "(:locale)", locale: /en|ru/ do
    root to: 'home#index'
    match '/regions/:id/hotels(/sort/:column::dir)(/page/:page)', to: 'regions#hotels', as: :hotels_region
    match '/hotels/:city_id/:id', to: 'hotels#show', as: :hotel_city
    match '/tours/:tour_type_id/:id', to: 'tours#show', as: :tour
    match '/tours/:id(/sort/:column::dir)(/page/:page)', to: 'tour_types#show', as: :tour_type
    post '/orders/relatives/:relative_type/:city_id', to: 'orders#relatives', as: :orders_relatives
    post '/orders/cities/:relative_type', to: 'orders#cities', as: :orders_cities
    resources :hotels, only: [:show]
    resources :pages, only: [:show]
    resources :news, only: [:show]
    resources :regions, only: [:index, :show, :hotels]
    resources :sights, only: [:index, :show]
    resources :orders, only: [:new, :create]
  end
end