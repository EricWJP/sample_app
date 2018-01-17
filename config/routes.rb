Rails.application.routes.draw do
  root 'static_pages#home'

  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about'
  get 'static_pages/contact'

  # resources :static_pages
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root "application#hello"
end
