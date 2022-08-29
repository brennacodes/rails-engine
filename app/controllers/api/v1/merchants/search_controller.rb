module Api
  module V1
    module Merchants
      class SearchController < ApplicationController
        # This function takes in a name parameter and returns a list of merchants that match the name
        def index
          merchants = Merchant.find_all_by_input(params[:name])
          serialize_merchant(merchants)
        end

        # If the params hash has an id key, find the merchant by id, otherwise find the merchant by name
        def show
          type = find_type
          if params[:id] || params[:name] == ""
            return json_missing_input
          elsif params[:id]
            merchant = Merchant.find(params[:id])
          elsif params[:name]
            merchant = Merchant.find_by_input(params[:name])
          else
            return json_not_found(params[:name]||params[:id])
          end
          serialize_merchant(merchant)
        end
      end
    end
  end
end