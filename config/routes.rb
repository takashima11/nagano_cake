Rails.application.routes.draw do



  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  namespace :public do
  end

    get 'current_customer/show' => 'public/customers#show'
    get 'current_customer/information/edit' => 'public/customers#edit'
    patch 'current_customer/show' => 'public/customers#update'
    put 'current_customer/show' => 'public/customers#update'
    get 'current_customer/unsubscribe' => 'public/customers#unsubscribe', as: 'unsubscribe'
    patch 'current_customer/withdrawal' => 'public/customers#withdrawal', as: 'withdrawal'


    get '/admin' => 'admin/homes#top'



    root to: 'public/homes#top'
    get '/about' => 'public/homes#about',as: 'about'


end
