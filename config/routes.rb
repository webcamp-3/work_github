Rails.application.routes.draw do
  root to: 'public/homes#top'
  
  devise_for :customers,skip: [:passwords], controllers: {registrations: "public/registrations",sessions: 'public/sessions'}
  devise_for :admin,skip: [:registrations, :passwords] , controllers: {sessions: "admin/sessions"}

  namespace :admin do
    root to: '/admin/homes#top'
    get 'homes/top' => 'homes#top'
    resources :orders, only: [:show, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :edit, :create, :update]
    resources :items, only: [:new, :index, :show, :edit, :create, :update]
    resources :order_details, only: [:update]
  end

  namespace :public do
    get 'homes/top' => 'homes#top'
    get 'homes/about'
    get 'customers/unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw'
    post 'orders/confirmation' => 'orders#confirmation'
    get 'orders/completion' => 'orders#completion'
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :addresses, only: [:index, :edit, :update, :create, :destroy]
    resources :orders, only: [:new, :index, :show, :create]
    resources :cart_items, only: [:index, :update, :destroy, :create]
    resource :customers, only: [:show, :edit, :update]
    resources :items, only: [:index, :show]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
