module Api
  module V1
    module Items
      class SearchController < ApplicationController
        before_action :check_input, only: [:find, :find_all]

        def index
          check = check_input
          if check == nil 
            return json_missing_input 
          else
            item = Item.find_all_by_input(check[0], check[1])
            serialize_item(item)
          end
        end

        def show
          check = check_input
          if check == nil 
            return json_missing_input
          else
            item = Item.find_by_input(check[0], check[1])
            serialize_item(item)
          end
        end

        private
          # It checks to see if the user has entered any search parameters, 
          # and if not, it returns a 204 status code and an error message
          def check_input
            type = find_type
            input = params[type.to_sym]
            type.empty? || input.empty? ? nil : [type, input]
          end

          # # Returns:
          # #   The type of attribute that is being searched for.
          # def find_type
          #   return type = "name" if params[:name]
          #   return type = "description" if params[:description]
          #   return type = "unit_price" if params[:unit_price]
          #   return type = "merchant_id" if params[:merchant_id]
          # end
      end
    end
  end
end