class Cleaning < ApplicationRecord
  belongs_to :user
  belongs_to :car
  attr_accessor :date, :time

  has_attachments :photos, maximum: 4

  # after_update :send_sms_to_customer
  # after_create :broadcast_cleaning

  def price
    car.category.price
  end

  private

  def broadcast_cleaning
    ActionCable.server.broadcast("cleanings", {
      cleaning_partial: ApplicationController.renderer.render(
        # partial: "cleanings/recap_for_client",
        locals: { car: self.car }
      )
    })
  end
end
