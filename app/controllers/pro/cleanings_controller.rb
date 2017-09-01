class Pro::CleaningsController < ApplicationController
  before_action :find_cleaning, only: [:show, :edit, :update, :destroy]

  def show
    @cleaner = User.find(@cleaning.user_id)
    @cleanings = @cleaner.cleanings.where.not(id: @cleaning.id)
    @car = Car.find(@cleaning.car_id)
    @ratings = []
  end

  def edit
    @car = Car.find(@cleaning.car_id)
  end

  def update
    if @cleaning.status == "pending"
      @cleaning.update(status: "accepted")
    elsif @cleaning.status == "accepted"
      @cleaning.update(status: "confirmed")
    elsif @cleaning.status == "confirmed"
      @cleaning.update(cleaning_params)
    elsif @cleaning.status == "complete"
      send_sms_to_customer(@cleaning)
      @cleaning.update(status: "archived")
    end
    redirect_to pro_dashboard_path
  end

  def destroy
  end

  private

  def cleaning_params
    params.require(:cleaning).permit(:status, photos: [])
  end

  def find_cleaning
    @cleaning = Cleaning.find(params[:id])
  end

  def send_sms_to_customer(cleaning)
    callr_api = CALLR::Api.new(ENV["CALLR_USER_NAME"], ENV["CALLR_PASSWORD"])
    body = "#{cleaning.user.firstname} has cleaned your car. Go check : #{client_cleaning_url(cleaning)}"
    callr_api.call(
      'sms.send',
      'SMS',
      "+33681503710",
      body,
      nil
    )
  end
end
