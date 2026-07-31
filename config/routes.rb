Rails.application.routes.draw do

  root 'home#index'
  namespace :admin do
    root 'dashboard#index'
    resources :categories
  end

  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registration: 'users/registration'
      }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
