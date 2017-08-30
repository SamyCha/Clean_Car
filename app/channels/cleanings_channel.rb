class CleaningsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "cleanings"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
