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
    elsif cleaning_params[:requirements].blank?
      flash[:alert] = "You need to confirm the requirements"
      redirect_to new_cleaning_path
    else

      date = params[:cleaning][:date].split('-')
      time = params[:cleaning][:time].split(':')
      period = DateTime.new(date[2].to_i, date[1].to_i, date[0].to_i, time[0].to_i, time[1].to_i)

      params[:cleaning].delete(:time)
      params[:cleaning].delete(:date)

      params[:cleaning][:period] = period

      @cleaning = Cleaning.new(cleaning_params)
      users = User.all
      cleaner = User.where(cleaner: true).near(cleaning_params[:place], 20).first

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
    if @cleaning.status == "pending"
      @cleaning.update(status: "accepted")
    elsif @cleaning.status == "accepted"
      @cleaning.update(status: "confirmed")
    elsif @cleaning.status == "confirmed"
      @cleaning.update(cleaning_params)
    elsif @cleaning.status == "complete"
      @cleaning.update(status: "archived")
    end
    redirect_to dashboard_path
  end

  def destroy
  end

  private

  def cleaning_params
    params.require(:cleaning).permit(:car_id, :place, :period, :comment_access, :requirements, :status, photos: [])
  end

  def find_cleaning
    @cleaning = Cleaning.find(params[:id])
  end
end
