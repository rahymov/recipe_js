Rails.application.routes.draw do

  root "recipes#index"
  post '/rate' => 'rater#create', :as => 'rate'
  resolve("ActiveStorage::Variant") { |variant, options| main_app.route_for(:rails_variant, variant, options) }
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :recipes

  resources :recipes do
    collection { post :search, to: 'recipes#index' }
  end
  resources :recipes do
    resources :comments
  end
  get '/categories/:id/recipes', to: "categories#index", as: "/category_recipes"
  resources :users, only: [:index, :show] do
    resources :recipes, only: [:index, :show]
  end
  get '/comments' => redirect('/')
end
