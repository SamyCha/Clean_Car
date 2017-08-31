class Cleaning < ApplicationRecord
  belongs_to :user
  belongs_to :car

  attr_accessor :date, :time

  geocoded_by :place
  after_validation :geocode, if: :place_changed?
  has_attachments :photos, maximum: 2

  # after_update :send_sms_to_customer
  after_create :broadcast_cleaning
  after_update :broadcast_accepted

  def price
    car.category.price
  end

  private

  # def broadcast_cleaning
  #   ActionCable.server.broadcast("cleanings", {
  #     cleaning_partial: ApplicationController.renderer.render(
  #       partial: "cleanings/recap_for_client",
  #       locals: { car: self.car }
  #     )
  #   })
  def broadcast_cleaning
    ActionCable.server.broadcast("paid", {
      paid_partial: ApplicationController.renderer.render(
        partial: "shared/card_cleaning_for_cleaner_dashboard",
        locals: { missions: user.cleanings.where(status: "pending").or(user.cleanings.where(status: "accepted")).or(user.cleanings.where(status: "confirmed")).sort_by(&:status).reverse}
      ),
      current_user_id: user.id
    })
  end

  def broadcast_accepted
    ActionCable.server.broadcast("accepted", {
      message_partial: ApplicationController.renderer.render(
        partial: "users/cleaner_recap",
        locals: { cleaner: user, ratings: [] }
      )
    })
  end

  def send_sms_to_customer
    if status == "complete"
     callr_api = CALLR::Api.new(ENV["CALLR_USER_NAME"], ENV["CALLR_PASSWORD"])
     to = self.car.user.phonenumber
     body = "#{self.user.firstname} has cleaned your car"
     callr_api.call(
       'sms.send',
       'CLEAN',
       to,
       body,
       nil
     )
     end
   end



end
