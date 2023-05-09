Rails.application.routes.draw do
  resources :websites
  match "/delayed_job" => DelayedJobWeb, :anchor => false, :via => [:get, :post]
  get 'admin' => 'admin#index'
  resources :batchs, only: [:index, :create]
  resources :diags, only: [:index, :create, :show], path: ''
  patch '/:id' => 'diags#create'
  root to: 'diags#index'
end
