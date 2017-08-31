class Client::OrdersController < ApplicationController
  def show
    @order = Order.where(state: 'paid').find(params[:id])
    @cleaning = @order.cleaning
    @cleaner = @order.cleaning.user
    @ratings = []
  end

end
