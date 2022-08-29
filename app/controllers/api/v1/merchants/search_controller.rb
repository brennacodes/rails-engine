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
          if params[:id]
            merchant = Merchant.find(params[:id])
          elsif params[:name]
            merchant = Merchant.find_by_input(params[:name])
          else
            json_response({ errors: "Could not find merchant that matched with #{params[:name]}" }, :not_found)
          end
          serialize_merchant(merchant)
        end
      end
    end
  end
end