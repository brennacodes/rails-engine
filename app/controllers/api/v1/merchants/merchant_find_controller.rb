module Api
  module V1
    module Merchants
      class MerchantFindController < ApplicationController
        def find
          @merchant = Merchant.find_by_input(params[:search])
        end

        def find_all
          @merchants = Merchant.find_all_by_input(params[:search])
        end
      end
    end
  end
end