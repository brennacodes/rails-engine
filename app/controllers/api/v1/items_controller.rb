module Api
  module V1
    class ItemsController < ApplicationController
      before_action :set_item, only: %i[ show update destroy ]

      def index
        items = Item.all
        serialize_item(items)
      end

      def show
        serialize_item(@item)
      end

      def create
        item = Item.new(item_params)

        if item.save
          serialize_item(item, :created)
        else
          serialize_item(item.errors, :unprocessable_entity)
        end
      end

      def update
        if @item.update(item_params)
          serialize_item(@item, :ok)
        else
          serialize_item(@item.errors, :unprocessable_entity)
        end
      end

      def destroy
        @item.destroy
      end

      private
        def set_item
          @item = Item.find(params[:id])
        end

        def item_params
          params.require(:item).permit(:name, :description, :unit_price, :precision, :merchant_id)
        end
    end
  end
end