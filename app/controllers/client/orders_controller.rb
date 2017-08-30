class Client::OrdersController < ApplicationController
  def create
    cleaning = Cleaning.find(params[:cleaning])
    order  = Order.create!(cleaning: cleaning, amount: cleaning.price, state: 'pending')

    redirect_to new_client_order_payment_path(order)
  end

  def show
    @order = Order.where(state: 'paid').find(params[:id])
    @cleaning = @order.cleaning
    @cleaner = @order.cleaning.user
    @ratings = []
  end

end
