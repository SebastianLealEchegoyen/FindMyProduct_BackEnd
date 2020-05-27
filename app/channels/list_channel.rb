class ListChannel < ApplicationCable::Channel
  def subscribed
     stream_from "super_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
