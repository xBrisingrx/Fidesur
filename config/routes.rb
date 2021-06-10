# == Route Map
#
#                    Prefix Verb   URI Pattern                                                                              Controller#Action
#                      root GET    /                                                                                        apples#index
#                 main_home GET    /main/home(.:format)                                                                     main#home
#                   sectors GET    /sectors(.:format)                                                                       sectors#index
#                           POST   /sectors(.:format)                                                                       sectors#create
#                new_sector GET    /sectors/new(.:format)                                                                   sectors#new
#               edit_sector GET    /sectors/:id/edit(.:format)                                                              sectors#edit
#                    sector GET    /sectors/:id(.:format)                                                                   sectors#show
#                           PATCH  /sectors/:id(.:format)                                                                   sectors#update
#                           PUT    /sectors/:id(.:format)                                                                   sectors#update
#                           DELETE /sectors/:id(.:format)                                                                   sectors#destroy
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
  
  root 'apples#index'
  get 'main/home'
  resources :sectors
    post '/sectors/disable'
  resources :apples do
    resources :fields
  end
    post '/apples/disable'
    post '/fields/disable'
  resources :clients
    post '/clients/disable'
end
