module Api
  module V1
    module Merchants
      class SearchController < ApplicationController
        def index
          if nil_check == true
            json_missing_input
          elsif check_input == nil
            check = check_input
            json_not_found(check[0], check[1])
          else
            merchant = Merchant.find_all_by_input(params[:name])
            return json_not_found("name", check_input[1]) if merchant == nil
            serialize_merchant(merchant)
          end
        end

        def show
          if nil_check == true
            json_missing_input
          elsif check_input == nil
            check = check_input
            json_not_found(check[0], check[1])
          else
            merchant = Merchant.find_by_input(params[:name])
            return json_not_found("name", params[:name]) if merchant == nil
            serialize_merchant(merchant)
          end
        end

        private
          def nil_check
            return true if check_input == nil
          end

          # It checks to see if the user has entered any search parameters, 
          # and if not, it returns a 204 status code and an error message
          def check_input
            return nil if params[:name] == nil
            return nil if params[:name].empty?
            ["name", params[:name]]
          end

          def merchant_params
            params.permit(:name)
          end
        
      end
    end
  end
end