module Api
  module V1
    module Items
      class SearchController < ApplicationController
        before_action :check_input, only: [:find, :find_all]

        def index
          items = Item.find_all_by_input(check_input[0], check_input[1])
          serialize_item(items)
        end

        def show
          item = Item.find_by_input(check_input[0], check_input[1])
          serialize_item(item)
        end

        private
          # It checks to see if the user has entered any search parameters, 
          # and if not, it returns a 204 status code and an error message
          def check_input
            type = find_type
            input = params[type.to_sym]
            if input.empty?
              render json: { data: {}, error: 'Missing search parameters. Please try again' }, status: 204 
            else
              return type, input
            end
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