Rails.application.routes.draw do
  resources :diags, only: [:index, :create, :show]
  root to: 'diags#index'
end
