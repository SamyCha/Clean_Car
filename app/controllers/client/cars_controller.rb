class Client::CarsController < ApplicationController
  before_action :find_car, only: [:edit, :update, :destroy]

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    @car.update(user: current_user)
    if @car.save
      redirect_to new_client_cleaning_path
    else
      flash[:alert] = "please enter the right informations"
      redirect_to new_client_car_path
    end
  end

  def edit
  end

  def update
    @car.update(params[:car])
    redirect_to client_car_path
  end

  def destroy
    @car.destroy
    redirect_to client_dashboard_path
  end


private

  def car_params
    params.require(:car).permit(:immatriculation, :brand, :model, :color, :category_id)
  end

  def find_car
    @car = Car.find(params[:id])
  end
end
