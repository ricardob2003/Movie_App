Rails.application.routes.draw do
  resources :movies do 
  root "movies#index"
    resources :reviews
  end 
end