Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :items do
        get '/find', controller: :search, action: :show
        get '/find_all', controller: :search, action: :index
        get '/:item_id/merchant', controller: :merchants, action: :show, as: :merchant
      end

      resources :items
      
      namespace :merchants do
        get '/find', controller: :search, action: :show
        get '/find_all', controller: :search, action: :index
        get '/:merchant_id/items', controller: :items, action: :index, as: :items
      end

      resources :merchants, only: [:index, :show]
    end
  end
end
