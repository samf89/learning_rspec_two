Rails.application.routes.draw do

  root 'static_pages#home'

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
