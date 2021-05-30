Rails.application.routes.draw do
  root 'main#home'
  get 'main/home'
  resources :sectors
    post '/sectors/disable'
  resources :apples
    post '/apples/disable'
end
