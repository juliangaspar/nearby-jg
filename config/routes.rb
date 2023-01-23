Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home", as: :home

  resources :users, only: %i[show edit], shallow: true do
    get 'showtool', to: 'users#showtool'
    resources :bookings, only: :index
  end

  resources :items do
    resources :bookings, except: %i[edit] do
      resources :reviews, only: %i[index new create]
    end
  end

  resources :reviews, only: %i[destroy]
  resources :chatrooms, only: %i[index show create] do
    resources :messages, only: :create
  end
end
