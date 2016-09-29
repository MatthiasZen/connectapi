Rails.application.routes.draw do
  root to: 'pages#index'
  get    "pages/:id",      to: "pages#show"
  post "pages/:id", to: "pages#update"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
