Rails.application.routes.draw do
  get 'gandi_api/index'

  get 'gandi_api/show'

  post 'gandi_api/update'

  get 'pages/update'

  root to: 'pages#index'
  get "pages/:id", to: "pages#show"
  get "expire", to: "pages#expire"
  post "pages/:id", to: "pages#edit"
  put "pages/:id", to: "pages#update"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
