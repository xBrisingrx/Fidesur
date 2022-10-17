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

  resources :projects
  resources :project_types
  resources :materials
  resources :providers
  post '/providers/disable'

  resources :sale_products, except: [:destroy, :show]
  get 'sale_product/:product_type/:product_id', to: 'sale_products#show', as: 'sale_product_detail'
  get 'detalle_venta_lote/:product_id', to: 'sale_products#index', as: 'show_land_sale'
  get 'get_totales_cuota/:product_type/:product_id', to: 'sale_products#get_totales_cuota', as: 'get_totales_cuota'
  get '/ver_todos_los_lotes', to: "sale_products#all_lands", as: 'ver_todos_los_lotes'
  # resources :land_sale, only: [:index, :new, :create]
  # resources :land_fees do 
  #   get 'partial_payment/:land_fee_id', to: 'land_fee_payments#new', as: 'partial_payment'
  #   post 'partial_payment', to: 'land_fee_payments#create', as: 'register_partial_payment'
  #   resources :land_fee_payments
  # end
  # resources :land_payments

  # resources :apples do
  #   resources :fields
  # end
  #   post '/apples/disable'
  #   post '/fields/disable'
  # resources :clients
  #   post '/clients/disable'
  # get 'detalle_venta_lote/:field_id', to: 'field_sale#index', as: 'show_field_sale'
  # resources :field_sale
  get 'sales/new/:product_type/:product_id', to: 'sales#new', as: 'new_sale'
  post 'sales/reset_payments/:sale_id', to: 'sales#reset_payments', as: 'reset_payments'
  post 'sales/send_payments', to: 'sales#send_payments'
  get 'pay_sale/:data', to: 'sales#pay', as: 'pay_land'
  get 'start_field_sale/:field_id', to: 'sales#start_field_sale', as: 'start_field_sale'
  resources :sales, only: [:create, :destroy]
  
  get 'detalle_pago_cuota/:id', to: 'land_fees#detalle_pago_cuota', as: 'detalle_pago_cuota'


  # Fees routes
  get 'fees/:sale_id', to: 'fees#index'
  get 'fees/detail/:id', to: 'fees#show', as: :fee_detail
  get 'detalle_pagos/:id', to: 'fees#details', as: 'detalle_pagos'
  get 'partial_payment/:fee_id', to: 'fee_payments#new', as: 'pago_parcial'
  resources :fees, only: [:create, :new, :update] do
    get 'partial_payment/:fee_id', to: 'fee_payments#new', as: 'partial_payment'
    post 'partial_payment', to: 'fee_payments#create', as: 'register_partial_payment'
    resources :fee_payments
  end
  # End fees routes 

  localized do 

    root 'apples#index'
    
    
    resources :users
    resources :client_fields
    resources :sectors
    post '/sectors/disable'
      
    resources :apples do
      resources :lands, only: [:index, :new, :create, :edit, :update]
      resources :fields
    end
    post '/apples/disable'
    post '/fields/disable'
    resources :clients
      post '/clients/disable'
      get '/clients/:id/lotes_cliente', to: 'clients#lotes_cliente', as: 'lotes_cliente'
    # end

  end # end localized
end 