# == Route Map
#
#                    Prefix Verb   URI Pattern                                                                              Controller#Action
#                      root GET    /                                                                                        apples#index
#                 main_home GET    /main/home(.:format)                                                                     main#home
#                   sectors GET    /sectores(.:format)                                                                      sectors#index
#                    sector GET    /sector/:id(.:format)                                                                    sectors#show
#                           POST   /sectors(.:format)                                                                       sectors#create
#                new_sector GET    /sectors/new(.:format)                                                                   sectors#new
#               edit_sector GET    /sectors/:id/edit(.:format)                                                              sectors#edit
#                           PATCH  /sectors/:id(.:format)                                                                   sectors#update
#                           PUT    /sectors/:id(.:format)                                                                   sectors#update
#           sectors_disable POST   /sectors/disable(.:format)                                                               sectors#disable
#              apple_fields GET    /apples/:apple_id/fields(.:format)                                                       fields#index
#                           POST   /apples/:apple_id/fields(.:format)                                                       fields#create
#           new_apple_field GET    /apples/:apple_id/fields/new(.:format)                                                   fields#new
#          edit_apple_field GET    /apples/:apple_id/fields/:id/edit(.:format)                                              fields#edit
#               apple_field GET    /apples/:apple_id/fields/:id(.:format)                                                   fields#show
#                           PATCH  /apples/:apple_id/fields/:id(.:format)                                                   fields#update
#                           PUT    /apples/:apple_id/fields/:id(.:format)                                                   fields#update
#                           DELETE /apples/:apple_id/fields/:id(.:format)                                                   fields#destroy
#                    apples GET    /apples(.:format)                                                                        apples#index
#                           POST   /apples(.:format)                                                                        apples#create
#                 new_apple GET    /apples/new(.:format)                                                                    apples#new
#                edit_apple GET    /apples/:id/edit(.:format)                                                               apples#edit
#                     apple GET    /apples/:id(.:format)                                                                    apples#show
#                           PATCH  /apples/:id(.:format)                                                                    apples#update
#                           PUT    /apples/:id(.:format)                                                                    apples#update
#                           DELETE /apples/:id(.:format)                                                                    apples#destroy
#            apples_disable POST   /apples/disable(.:format)                                                                apples#disable
#            fields_disable POST   /fields/disable(.:format)                                                                fields#disable
#                   clients GET    /clients(.:format)                                                                       clients#index
#                           POST   /clients(.:format)                                                                       clients#create
#                new_client GET    /clients/new(.:format)                                                                   clients#new
#               edit_client GET    /clients/:id/edit(.:format)                                                              clients#edit
#                    client GET    /clients/:id(.:format)                                                                   clients#show
#                           PATCH  /clients/:id(.:format)                                                                   clients#update
#                           PUT    /clients/:id(.:format)                                                                   clients#update
#                           DELETE /clients/:id(.:format)                                                                   clients#destroy
#           clients_disable POST   /clients/disable(.:format)                                                               clients#disable
#        rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  
  resources :sessions, only: [:new, :create, :destroy]  
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  # resources :apples do
  #   resources :fields
  # end
  #   post '/apples/disable'
  #   post '/fields/disable'
  # resources :clients
  #   post '/clients/disable'

  post 'sales', to: 'sales#create'
  get 'start_field_sale/:field_id', to: 'sales#start_field_sale', as: 'start_field_sale'

  localized do 

    root 'apples#index'
    
    
    resources :users
    resources :client_fields
    # scope '(:locale)', locale: /es/ do
      # Sectores
      # get '/sectores', to:'sectors#index', as: 'sectors'
      # get '/sector/:id', to: 'sectors#show', as: 'sector'
      resources :sectors #, only: [:new, :create, :edit, :update]
      post '/sectors/disable'
      
      resources :apples do
        resources :fields
      end
      post '/apples/disable'
      post '/fields/disable'
      resources :clients
        post '/clients/disable'
    # end

    
    # get 'signup', to: 'users#new', as: 'signup'
    # get 'login', to: 'sessions#new', as: 'login'
    # get 'logout', to: 'sessions#destroy', as: 'logout'

  end # end localized
end 
