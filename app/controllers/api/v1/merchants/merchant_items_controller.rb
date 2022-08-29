module Api
  module V1
    module Merchants
      class MerchantItemsController < ApplicationController
        def index
          merchant = Merchant.find(params[:merchant_id])
          items = merchant.items
          json_response(ItemSerializer.new(items))
        end
      end
    end
  end
end