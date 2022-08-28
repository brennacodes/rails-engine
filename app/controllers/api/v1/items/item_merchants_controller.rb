module Api
  module V1
    module Items
      class ItemMerchantController < ApplicationController
        def show
          item = Item.find(params[:item_id])
          @merchant = item.merchant
        end
      end
    end
  end
end