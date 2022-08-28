Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: 'merchants/merchant_items'
      end

      namespace :merchants do
        get '/find', controller: :merchant_find, action: :find
        get '/find_all', controller: :merchant_find, action: :find_all
      end
      
      resources :items do
        resources :merchant, only: [:show], controller: 'items/item_merchant'
      end

      namespace :items do
        get '/find', controller: :items_find, action: :find
        get '/find_all', controller: :items_find, action: :find_all
      end
    end
  end
end
