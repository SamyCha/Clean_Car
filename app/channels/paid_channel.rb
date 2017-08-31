class PaidChannel < ApplicationCable::Channel
  def subscribed
    stream_from "paid"
  end
end
