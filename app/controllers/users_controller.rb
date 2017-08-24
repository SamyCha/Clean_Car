class UsersController < ApplicationController
   before_action :find_user, only: [:show, :edit, :update, :destroy]

  def index
    @title = "Index - My Clean Car"

    if params["location_address"]
      @address = params["location_address"]
    # else
    #   @address = "Le Wagon Bordeaux"
    end
    @users = User.all
<<<<<<< Updated upstream
<<<<<<< Updated upstream
<<<<<<< Updated upstream
    # @address = "Bordeaux"
    @cleaners = User.where(cleaner: true).near(@address, 500).first(5)

=======
=======
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
    @cleaners = User.where(cleaner: true).near(@address, 20)
    puts "hi #{@cleaners}"
    #ici ce n'est pas tous les User que l'on affiche mais seulement les cleaners (à corriger)
>>>>>>> Stashed changes
    @hash = Gmaps4rails.build_markers(@cleaners) do |cleaner, marker|
      marker.lat cleaner.latitude
      marker.lng cleaner.longitude
      marker.picture({ url: "https://image.prntscr.com/image/WtApDFKyS9SqShLkO0YrEw.png", width: 32, height: 32 })
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
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
