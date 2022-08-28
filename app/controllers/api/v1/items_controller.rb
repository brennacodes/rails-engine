module Api
  module V1
    class ItemsController < ApplicationController
      before_action :set_item, only: %i[ show update destroy ]

      def index
        items = Item.all
        render json: ItemSerializer.new(items)
      end

      def show
        render json: ItemSerializer.new(@item)
      end

      def create
        @item = Item.new(item_params)

        if @item.save
          render json: @item, status: :created, location: @item
        else
          render json: @item.errors, status: :unprocessable_entity
        end
      end

      def update
        if @item.update(item_params)
          render json: @item, status: :ok, location: @item
        else
          render json: @item.errors, status: :unprocessable_entity
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