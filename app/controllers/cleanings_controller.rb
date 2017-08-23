class CleaningsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @cleaning = Cleaning.new
    @cars = Car.where(user_id: current_user.id)
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
