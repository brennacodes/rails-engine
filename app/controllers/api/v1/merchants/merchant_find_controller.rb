module Api
  module V1
    module Merchants
      class MerchantFindController < ApplicationController
        def find
          if params[:id]
            merchant = Merchant.find(params[:id])
          elsif params[:name]
            merchant = Merchant.find_by_input(params[:name])
          else
            json_response({ errors: "Could not find merchant that matched with #{params[:name]}" }, :not_found)
          end
          serialize_merchant(merchant)
        end

        def find_all
          merchants = Merchant.find_all_by_input(params[:name])
          serialize_merchant(merchants)
        end
      end
    end
  end
end