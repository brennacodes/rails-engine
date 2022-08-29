module Api
  module V1
    class MerchantsController
      def index
        merchants = Merchant.all
        json_response(MerchantSerializer.new(merchants))
      end

      def show
        merchant = Merchant.find(params[:id])
        json_response(MerchantSerializer.new(merchant))
      end
    end
  end
end