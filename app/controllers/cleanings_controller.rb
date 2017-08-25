class CleaningsController < ApplicationController
  before_action :find_cleaning, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
    @cleaner = User.find(@cleaning.user_id)
    @cleanings = @cleaner.cleanings.where.not(id: @cleaning.id)
    @car = Car.find(@cleaning.car_id)
    @ratings = []
  end

  def new
    @cleaning = Cleaning.new
    @cars = Car.where(user_id: current_user.id)
  end

  def create
    if cleaning_params[:place].blank?
      flash[:alert] = "Please enter a location"
      redirect_to new_cleaning_path
    else

      date = params[:clean][:date].split('-')
      time = params[:clean][:time].split(':')
      period = DateTime.new(date[2].to_i, date[1].to_i, date[0].to_i, time[0].to_i, time[1].to_i)

      params[:clean].delete(:time)
      params[:clean].delete(:date)

      params[:clean][:period] = period

      @cleaning = Cleaning.new(cleaning_params)
      users = User.all
      cleaner = User.where(cleaner: true).near("Bordeaux", 20).first

      @cleaning.update(user: cleaner)

      if @cleaning.save
        redirect_to cleaning_path(@cleaning)
      else
        flash[:alert] = "An error has occurred..."
        redirect_to new_cleaning_path
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def cleaning_params
    params.require(:clean).permit(:car_id, :place, :period, :comment_access)
  end

  def find_cleaning
    @cleaning = Cleaning.find(params[:id])
  end
end
