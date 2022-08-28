module Api
  module V1
    module Items
      class ItemFindsController < ApplicationController
        def find
          item = Item.find_by_input(type, params[:search])
          render json: ItemSerializer.new(item)
        end

        def find_all
          items = Item.find_all_by_input(type, params[:search])
          render json: ItemSerializer.new(items)
        end
      end
    end
  end
end