class OrdersController < ApplicationController
  def create
    cleaning = Cleaning.find(params[:cleaning_id])
    order  = Order.create!(cleaning: cleaning, amount: cleaning.price, state: 'pending')

    redirect_to new_order_payment_path(order)
  end

  def show
    @order = Order.where(state: 'paid').find(params[:id])
  end

end
