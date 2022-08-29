Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', controller: :search, action: :show
        get '/find_all', controller: :search, action: :index
        get '/:merchant_id/items', controller: :merchant_items, action: :index, as: :items
      end

      namespace :items do
        get '/find', controller: :search, action: :show
        get '/find_all', controller: :search, action: :index
        get '/:item_id/merchant', controller: :item_merchant, action: :show, as: :merchant
      end
      
      resources :merchants, only: [:index, :show]

      resources :items
    end
  end
end
