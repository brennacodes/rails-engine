module Api
  module V1
    module Items
      class ItemFindController < ApplicationController
        def find
          @item = Item.find_by_input(params[:search])
        end

        def find_all
          @items = Item.find_all_by_input(params[:search])
        end
      end
    end
  end
end