class ListChannel < ApplicationCable::Channel
  def subscribed
     stream_from "super_channel"
  end

  def unsubscribed
    
  end
end
