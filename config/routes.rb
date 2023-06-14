Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :forecast, only: [:index]
      resources :users, only: [:create]
      resources :sessions, only: [:create]
      resources :road_trip, only: [:create]
      resources :backgrounds, only: [:index]
      get 'book-search', to: 'book_search#index', as: 'book_search'
    end
  end
end
