class AcceptedChannel < ApplicationCable::Channel
  def subscribed
    stream_from "accepted"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
