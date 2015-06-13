Rails.application.routes.draw do
  resources :contacts do
    resources :phones
  end
end
