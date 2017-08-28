class UsersController < ApplicationController
   before_action :find_user, only: [:edit, :update, :destroy]

  def index
    @title = "Index - My Clean Car"

    if params["address"] != ""
      @address = params["address"]
    else
      @address = "Le Wagon Bordeaux"
    end
    @users = User.all
    @cleaners = User.where(cleaner: true).near(@address, 20).first(5)
    @ratings = []

    @hash = Gmaps4rails.build_markers(@cleaners) do |cleaner, marker|
      marker.lat cleaner.latitude
      marker.lng cleaner.longitude
      marker.picture({ url: "https://image.prntscr.com/image/WtApDFKyS9SqShLkO0YrEw.png", width: 32, height: 32 })
    end
  end

  def edit
    @title = "Dashboard"
  end

  def show
    @user = current_user
    if @user.cleaner
      @pendings = @user.cleanings.where(status: "pending")
      @confirmeds = @user.cleanings.where(status: "confirmed")
      @completes = @user.cleanings.where(status: "complete")
      @cleanings = [ @pendings, @confirmeds, @completes ]
    else
      @cars = Car.where(user_id: @user.id)
      @pendings = []
      @confirmeds = []
      @completes = []
      @cars.each do |car|
        car.cleanings.where(status: "pending").each { |cleaning| @pendings << cleaning }
        car.cleanings.where(status: "confirmed").each { |cleaning| @confirmeds << cleaning }
        car.cleanings.where(status: "complete").each { |cleaning| @completes << cleaning }
      end
      @cleanings = [ @pendings, @confirmeds, @completes ]
    end
  end

  def update
    @user.update(params[:user])
    redirect_to_restaurant_path
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

private

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :address, :phonenumber, :cleaner)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
