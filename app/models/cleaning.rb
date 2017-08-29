class Cleaning < ApplicationRecord
  belongs_to :user
  belongs_to :car
  attr_accessor :date, :time

  has_attachments :photos, maximum: 4

  after_update :send_sms_to_customer

  def price
    car.category.price
  end

  private

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
