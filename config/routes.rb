Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get '/about', to: 'homes#about'
  get 'home/about', to: 'homes#about' 
  resources :books
  resources :users
  
 
  resources :users, only: [:show, :edit, :update] do
    resources :books, only: [:new, :show,:create, :destroy, :edit, :update] 
  end
  
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
