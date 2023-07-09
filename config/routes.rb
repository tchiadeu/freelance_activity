Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#dashboard'
  resources 'bills', only: %i[show new create edit update destroy]
  resources 'clients', only: %i[show new create edit update destroy]
  resources 'banks', only: %i[new create edit update destroy]
end
