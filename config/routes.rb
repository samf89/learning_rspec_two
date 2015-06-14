Rails.application.routes.draw do

  resources :contacts do
    member do 
      post :hide
    end
    resources :phones
  end

end
