class CarsController < ApplicationController
  before_action :find_car, only: [:edit, :update, :destroy]

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    if @car.save
      redirect_to cars_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @car.update(params[:car])
    redirect_to_car_path
  end

  def destroy
    @car.destroy
    redirect_to cars_path
  end


private

  def car_params
    params.require(:car).permit(:immatriculation, :brand, :model, :color)
  end

  def find_car
    @car = Car.find(params[:id])
  end
end
