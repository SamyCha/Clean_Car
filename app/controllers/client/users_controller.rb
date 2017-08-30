class Client::UsersController < ApplicationController
   before_action :find_user, only: [:update, :destroy]

  def edit
    @user = current_user
    @title = "Dashboard"
  end

  def dashboard_cleaner
    @user = current_user
    @missions = @user.cleanings.where(status: "pending").or(@user.cleanings.where(status: "accepted")).or(@user.cleanings.where(status: "confirmed")).sort_by(&:status).reverse
    @completes = @user.cleanings.where(status: "complete")
    @cleanings = @user.cleanings
  end

  def show
    @user = current_user
    @cars = Car.where(user_id: @user.id)
    @pendings = []
    @accepteds = []
    @confirmeds = []
    @completes = []
    @cars.each do |car|
      car.cleanings.where(status: "pending").each { |cleaning| @pendings << cleaning }
      car.cleanings.where(status: "accepted").each { |cleaning| @accepteds << cleaning }
      car.cleanings.where(status: "confirmed").each { |cleaning| @confirmeds << cleaning }
      car.cleanings.where(status: "complete").each { |cleaning| @completes << cleaning }
    end
    @cleanings = [ @pendings, @accepteds, @confirmeds, @completes ]
  end

  def update
    @user.update(params[:user])
    redirect_to client_dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :address, :phonenumber, :cleaner)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
