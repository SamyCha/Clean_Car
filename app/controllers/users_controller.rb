class UsersController < ApplicationController
   before_action :find_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
    @cleaners = User.where.not(latitude: nil, longitude: nil)
#ici ce n'est pas tous les User que l'on affiche mais seulement les cleaners (à corriger)
    @hash = Gmaps4rails.build_markers(@cleaners) do |cleaner, marker|
      marker.lat flat.latitude
      marker.lng flat.longitude
      # marker.infowindow render_to_string(partial: "/cleaners/map_box", locals: { cleaner: cleaner })
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
