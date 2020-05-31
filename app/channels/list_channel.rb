class ListChannel < ApplicationCable::Channel
 

  def subscribed
     stream_from "super_channel"
  end

  def unsubscribed
  end

  def message(data)
    @num=data['id'].to_i
    @user=User.find(@num)
    @lists=@user.lists
    ActionCable.server.broadcast 'super_channel', message: @lists
  end

  def products(data)
    @num=data['id'].to_i
    @list=List.find(@num)
    @products=@list.products
    ActionCable.server.broadcast 'super_channel', message: @products
  end

end

