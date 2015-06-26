Rails.application.routes.draw do

  root 'static_pages#home'

  controller :static_pages do 
    get 'home'    => :home
    get 'help'    => :help
    get 'about'   => :about
    get 'contact' => :contact
  end

  resources :users 

  resources :contacts do
    member do 
      post :hide
    end
    resources :phones
  end

  get 'login'     => 'sessions#new'
  post 'login'    => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

end
