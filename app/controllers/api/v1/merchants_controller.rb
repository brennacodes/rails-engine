module Api
  module V1
    class MerchantsController
      before_action :set_merchant, only: %i[ show ]

      def index
        @merchants = Merchant.all
      end

      def show
        @merchant = Merchant.find(params[:id])
      end

      private
      def set_merchant
        @merchant = Merchant.find(params[:id])
      end
    end
  end
end