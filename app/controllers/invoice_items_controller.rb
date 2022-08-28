class InvoiceItemsController < ApplicationController
  before_action :set_invoice_item, only: %i[ show update destroy ]

  def index
    @invoice_items = InvoiceItem.all
  end

  def show
  end

  def create
    @invoice_item = InvoiceItem.new(invoice_item_params)

    if @invoice_item.save
      render :show, status: :created, location: @invoice_item
    else
      render json: @invoice_item.errors, status: :unprocessable_entity
    end
  end

  def update
    if @invoice_item.update(invoice_item_params)
      render :show, status: :ok, location: @invoice_item
    else
      render json: @invoice_item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @invoice_item.destroy
  end

  private
    def set_invoice_item
      @invoice_item = InvoiceItem.find(params[:id])
    end

    def invoice_item_params
      params.require(:invoice_item).permit(:item_id, :invoice_id, :quantity, :unit_price, :precision)
    end
end
