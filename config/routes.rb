Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', controller: :merchant_find, action: :find
        get '/find_all', controller: :merchant_find, action: :find_all
        # get '/:merchant_id/items', controller: :merchant_items, action: :index, as: :items
      end

      namespace :items do
        get '/find', controller: :item_find, action: :find
        get '/find_all', controller: :item_find, action: :find_all
        get '/:item_id/merchant', controller: :item_merchant, action: :show, as: :merchant
      end
      
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: :merchant_items
      end

      resources :items
    end
  end
end
