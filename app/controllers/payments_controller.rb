class PaymentsController < ApplicationController
    before_action :set_order

  def new
    @cleaning = Cleaning.find(params[:order_id])
    @cleaner = @cleaning.user
    @cleanings = @cleaner.cleanings.where.not(id: @cleaning.id)
    @ratings = []
  end

  def create
    customer = Stripe::Customer.create(
      source: params[:stripeToken],
      email:  params[:stripeEmail]
    )

    charge = Stripe::Charge.create(
      customer:     customer.id,   # You should store this customer id and re-use it.
      amount:       @order.amount_cents, # or amount_pennies
      description:  "Payment for cleaning #{@order.cleaning.id} for order #{@order.id}",
      currency:     @order.amount.currency
    )

    byebug

    @order.update(payment: charge.to_json, state: 'paid')
    redirect_to dashboard_path(current_user)

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_order_payment_path(@order)
  end

private

  def set_order
    @order = Order.where(state: 'pending').find(params[:order_id])
  end
end
