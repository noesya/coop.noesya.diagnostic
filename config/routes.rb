Rails.application.routes.draw do
  match "/delayed_job" => DelayedJobWeb, :anchor => false, :via => [:get, :post]
  resources :diags, only: [:index, :create, :show]
  root to: 'diags#index'
end
