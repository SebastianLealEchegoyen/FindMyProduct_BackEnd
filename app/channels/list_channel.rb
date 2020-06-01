class ListChannel < ApplicationCable::Channel
 

  def subscribed
     stream_from "super_channel"
  end

  def unsubscribed
  end

  def message(data)
    @num=data['id'].to_i
    @user=User.find(@num)
    @all= @user.lists
    @message=
      Jbuilder.encode  do |json|
      json.info @all do |list|  
      json.id list.id
      json.name list.name
      json.products list.products do |product|
      json.product_id product.id
      json.product_name product.name
      @help= @association= ListProduct.find_by(
          list_id: list.id,
          product_id: product.id)
      json.product_quantity @help.quantity
      end
  end
end
  ActionCable.server.broadcast 'super_channel', message: @message
  end

end

