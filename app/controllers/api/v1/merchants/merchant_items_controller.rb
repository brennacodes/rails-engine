module Api
  module V1
    module Merchants
      class MerchantItemsController < ApplicationController
        def index
          merchant = Merchant.find(params[:merchant_id])
          items = merchant.items
          serialize_item(items)
        end
      end
    end
  end
end