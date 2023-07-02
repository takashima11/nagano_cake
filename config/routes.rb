Rails.application.routes.draw do



  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

    get 'items' => 'public/items#index'
    get 'items/:id' => 'public/items#show', as: 'items/show'

  namespace :admin do

      root to: 'homes#top'
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show]
  end

  scope module: :public do
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only: [:index, :update, :destroy, :create]


    get 'current_customer/show' => 'customers#show'
    get 'current_customer/information/edit' => 'customers#edit'
    patch 'current_customer/show' => 'customers#update'
    put 'current_customer/show' => 'customers#update'
    get 'current_customer/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    patch 'current_customer/withdrawal' => 'customers#withdrawal', as: 'withdrawal'

    post 'orders/confirm' => 'orders#confirm'
    get 'orders/complete' => 'orders#complete'
    resources :orders, only: [:new, :index, :show, :create]


    root to: 'homes#top'
    get '/about' => 'homes#about',as: 'about'
  end

end
