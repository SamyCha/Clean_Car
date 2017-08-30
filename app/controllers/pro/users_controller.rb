class Pro::UsersController < ApplicationController
   before_action :find_user, only: [:update, :destroy]

  def edit
    @user = current_user
    @title = "Dashboard"
  end

  def show
    @user = current_user
    @missions = @user.cleanings.where(status: "pending").or(@user.cleanings.where(status: "accepted")).or(@user.cleanings.where(status: "confirmed")).sort_by(&:status).reverse
    @completes = @user.cleanings.where(status: "complete")
    @cleanings = @user.cleanings
  end

  def update
    @user.update(user_params)
    redirect_to pro_dashboard_path
  end

private

  def user_params
    params.require(:user).permit(:avatar, :email, :firstname, :lastname, :address, :phonenumber)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
