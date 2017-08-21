class UsersController < ApplicationController
   before_action :find_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
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
  end

  def update
    @ruser.update(params[:user])
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
