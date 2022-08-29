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
          json_response(MerchantSerializer.new(merchant))
        end

        def find_all
          merchants = Merchant.find_all_by_input(params[:name])
          json_response(MerchantSerializer.new(merchants))
        end
      end
    end
  end
end