Rails.application.routes.draw do

  root to: 'page#home'
  resources :books, only: :index

  namespace :api do
    resources :books, only: :show
  end
end
