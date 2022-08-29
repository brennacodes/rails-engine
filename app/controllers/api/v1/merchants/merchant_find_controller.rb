module Api
  module V1
    module Merchants
      class MerchantFindController < ApplicationController
        def find
          if params[:id]
            merchant = Merchant.find(params[:id])
          elsif params[:name]
            merchant = Merchant.find_by_input(params[:name])
          end
          render json: MerchantSerializer.new(merchant)
        end

        def find_all
          merchants = Merchant.find_all_by_input(params[:name])
          render json: MerchantSerializer.new(merchants)
        end
      end
    end
  end
end