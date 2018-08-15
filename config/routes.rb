Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root 'home#index'

  # reviews
  get 'reviews/create'
  get 'reviews/destroy'

  #user & userspec
  resources :userspecs
  devise_for :users

  # manuals
  resources :manuals do
    member do
      put "like", to: "manuals#upvote"
    end

    resources :comments
  end
  get 'manuals/category/:category' => "manuals#category"

  # custom
  get 'custom/info' => "custom#info"
  get 'custom' => "custom#index"
  get 'custom/category/:category' => "custom#category"

  # ranking
  get 'ranking/index'

  # shopping
  get 'shopping/index'
  get 'products/category/:category' => "products#category"


  # product
  resources :products do
    resources :reviews
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
