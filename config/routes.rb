Rails.application.routes.draw do

  root 'static_pages#home'

  resources :users 

  resources :contacts do
    member do 
      post :hide
    end
    resources :phones
  end

end
