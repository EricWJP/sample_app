Rails.application.routes.draw do

  root 'static_pages#home'

  # get 'static_pages/home'
  # get 'static_pages/help'
  # get 'static_pages/about'
  # get 'static_pages/contact'

  get '/home', to: 'static_pages#home'
  get '/help', to: 'static_pages#help', as: 'help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'


  get '/signup', to: 'users#new', as: "signup"
  post '/signup', to: 'users#create'

  resources :users

  # resources :static_pages
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root "application#hello"
end
