Rails.application.routes.draw do
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	devise_for :users

	root 'homes#top'
	get 'homes/about'

	resources :users,only: [:show,:edit,:update,:index] do
		resource :relationships, only: [:create, :destroy]
		get 'follows' => 'relationships#follower', as: 'follows'
		get 'followers' => 'relationships#followed', as: 'followers'
	end

	resources :quizzes do
		resource :favorites, only:[:create, :destroy]
		resources :quiz_comments, only:[:create, :destroy]
	end

	resources :notifications, only: [:index]
end
