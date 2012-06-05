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
    resources :regions do
      get :hotels, on: :member
    end
    match '/hotels/:region_id/:id', to: 'hotels#show', as: :hotel_region
    match '/hotels/:city_id/:id', to: 'hotels#show', as: :hotel_city
    match '/tours/:tour_type_id/:id', to: 'tours#show', as: :tour
    match '/tours/:id', to: 'tour_types#show', as: :tour_type
  end
end