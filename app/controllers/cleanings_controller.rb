class CleaningsController < ApplicationController
  before_action :find_cleaning, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
    @cleaning = Cleaning.new
    @cars = Car.where(user_id: current_user.id)
  end

  def create
    @cleaning = Cleaning.new(cleaning_params)
    @cleaning.update(user: current_user)

    if @cleaning.save
      redirect_to cleaning_path(@cleaning)
    else
      flash[:alert] = "An error has occurred..."
      redirect_to new_cleaning_path
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
    params.require(:cleaning).permit(:car_id)
  end

  def find_cleaning
    @cleaning = Cleaning.find(params[:id])
  end
end
