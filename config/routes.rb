Rails.application.routes.draw do
  get 'downgrades/create'
  resources :downgrades, only: [:create]
  resources :charges, only: [:new, :create]
  resources :wikis
  devise_for :users
  get 'about' => 'welcome#about'

  root 'welcome#index'
end
