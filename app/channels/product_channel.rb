class ProductChannel < ApplicationCable::Channel
  def subscribed
    stream_from "luci_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def products(data)
    @num=data['id'].to_i
    @list=List.find(@num)
    @products=@list.products
    ActionCable.server.broadcast 'luci_channel', message: @products
  end
  
end
