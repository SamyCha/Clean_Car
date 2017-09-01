class Client::CleaningsController < ApplicationController
  before_action :find_cleaning, only: [:show, :edit, :update, :destroy]

  def new
    @cleaning = Cleaning.new
    @cars = Car.where(user_id: current_user.id)
  end

  def show
    @cleaner = User.find(@cleaning.user_id)
    @cleanings = @cleaner.cleanings.where.not(id: @cleaning.id)
    @car = Car.find(@cleaning.car_id)
    @ratings = []
  end

  def create
    if cleaning_params[:place].blank?
      flash[:alert] = "Please enter a location"
      redirect_to new_client_cleaning_path
    elsif cleaning_params[:requirements].blank?
      flash[:alert] = "You need to confirm the requirements"
      redirect_to new_client_cleaning_path
    else

      date = params[:cleaning][:date].split('-')
      time = params[:cleaning][:time].split(':')
      period = DateTime.new(date[2].to_i, date[1].to_i, date[0].to_i, time[0].to_i, time[1].to_i)
      cleaner = User.where(cleaner: true).near(cleaning_params[:place], 20).first

      @cleaning = Cleaning.new(cleaning_params.merge(period: period, user: cleaner))
      if @cleaning.save
        order = Order.create!(cleaning: @cleaning, amount: @cleaning.price, state: 'pending')
        redirect_to new_client_order_payment_path(order)
      else
        flash[:alert] = "An error has occurred..."
        redirect_to new_client_cleaning_path
      end
    end
  end

  def edit

  end

  def update
    if @cleaning.status == "accepted"
      @cleaning.update(status: "confirmed")
    elsif @cleaning.status == "complete" && @cleaning.rating.nil?
      @cleaning.update(cleaning_params)
      redirect_to client_cleaning_path(@cleaning)
    elsif @cleaning.status == "complete" && @cleaning.rating
      @cleaning.update(cleaning_params)
    end
  end

  def destroy
  end

  private

  def cleaning_params
    params.require(:cleaning).permit(:car_id, :place, :period, :comment_access, :requirements, :rating, :status, photos: [])
  end

  def find_cleaning
    @cleaning = Cleaning.find(params[:id])
  end
end
