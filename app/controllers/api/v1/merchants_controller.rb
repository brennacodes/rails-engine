module Api
  module V1
    class MerchantsController
      def index
        # merchants = Merchant.all
        render json: MerchantSerializer.new(Merchant.all)
      end

      def show
        merchant = Merchant.find(params[:id])
        render json: MerchantSerializer.new(merchant)
      end
    end
  end
end