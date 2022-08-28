class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  before_action :find_type, only: [:find, :find_all]

  private
    def find_type
      type = "name" if params[:name]
      type = "description" if params[:description]
      type = "unit_price" if params[:unit_price]
      type = "merchant_id" if params[:merchant_id]
    end
end
