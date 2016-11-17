Rails.application.routes.draw do
  post 'gandi_api/index'

  get 'gandi_api/show'

  get 'pages/update'

  root to: 'pages#index'
  get    "pages/:id",      to: "pages#show"
  post "pages/:id", to: "pages#edit"
  put "pages/:id", to: "pages#update"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
