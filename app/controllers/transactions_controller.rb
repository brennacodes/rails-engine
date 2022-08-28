class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show update destroy ]

  def index
    @transactions = Transaction.all
  end

  def show
  end

  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      render :show, status: :created, location: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  def update
    if @transaction.update(transaction_params)
      render :show, status: :ok, location: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @transaction.destroy
  end

  private
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    def transaction_params
      params.require(:transaction).permit(:invoice_id, :credit_card_number, :credit_card_expiration_date, :result)
    end
end
