module Api
  module V1
    module Items
      class ItemFindController < ApplicationController
        before_action :check_input, only: [:find, :find_all]

        def find
          item = Item.find_by_input(check_input[0], check_input[1])
          serialize_response(item)
        end

        def find_all
          items = Item.find_all_by_input(check_input[0], check_input[1])
          serialize_response(items)
        end

        private
          def serialize_response(object)
            json_response(ItemSerializer.new(object))
          end

          def check_input
            type = find_type
            input = params[type.to_sym]
            if input.empty?
              render json: { data: {}, error: 'Missing search parameters. Please try again' }, status: 204 
            else
              return type, input
            end
          end

          def find_type
            return type = "name" if params[:name]
            return type = "description" if params[:description]
            return type = "unit_price" if params[:unit_price]
            return type = "merchant_id" if params[:merchant_id]
          end
      end
    end
  end
end