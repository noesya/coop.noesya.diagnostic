Rails.application.routes.draw do
  match "/delayed_job" => DelayedJobWeb, :anchor => false, :via => [:get, :post]
  get 'admin' => 'admin#index'
  resources :diags, only: [:index, :create, :show], path: ''
  patch '/:id' => 'diags#create'
  root to: 'diags#index'
end
