module Api
  module V1
    class MerchantsController
      def index
        @merchants = Merchant.all
      end
    end
  end
end
class MerchantsController < ApplicationController
  before_action :set_merchant, only: %i[ show update destroy ]


  def show
  end

  def create
    @merchant = Merchant.new(merchant_params)

    if @merchant.save
      render :show, status: :created, location: @merchant
    else
      render json: @merchant.errors, status: :unprocessable_entity
    end
  end

  def update
    if @merchant.update(merchant_params)
      render :show, status: :ok, location: @merchant
    else
      render json: @merchant.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @merchant.destroy
  end

  private
    def set_merchant
      @merchant = Merchant.find(params[:id])
    end

    def merchant_params
      params.require(:merchant).permit(:name)
    end
end
