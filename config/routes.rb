Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
  }

  root 'quizzes#index'
  get 'homes/about'
  get 'search' => 'search#search'

  resources :users, only: [:show, :edit, :update, :index] do
    collection do
      get 'home' => 'users#home'
    end
    resource :relationships, only: [:create, :destroy]
    get 'follows' => 'relationships#follower', as: 'follows'
    get 'followers' => 'relationships#followed', as: 'followers'
  end

  resources :quizzes do
    collection do
      get 'famous' => 'quizzes#famous'
    end
    resource :favorites, only: [:create, :destroy]
    resources :quiz_comments, only: [:create, :destroy]
  end

  resources :notifications, only: [:index] do
    collection do
      delete 'destroy_all' => 'notifications#destroy_all', as: 'destroy_all'
    end
  end
end
