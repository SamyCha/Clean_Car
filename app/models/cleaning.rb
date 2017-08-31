class Cleaning < ApplicationRecord
  belongs_to :user
  belongs_to :car

  attr_accessor :date, :time

  geocoded_by :place
  after_validation :geocode, if: :place_changed?
  has_attachments :photos, maximum: 4

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
    ActionCable.server.broadcast("cleanings", {
      # cleaning_partial: ApplicationController.renderer.render(
        # partial: "cleanings/recap_for_client"
        cleaning: "Hi, this is a socket ! :D"
      # )
    })
  end

  def broadcast_accepted
    ActionCable.server.broadcast("accepted", {
        accepted: "hello"
    })
  end

end
