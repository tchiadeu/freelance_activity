Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#dashboard'
  get 'administrative', to: 'pages#administrative'
  get 'profile', to: 'pages#profile'
  resources 'clients'
  resources 'bills', only: %i[show new create edit update destroy]
  resources 'banks', only: %i[new create edit update destroy]
end
