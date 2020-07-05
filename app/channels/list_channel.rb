# FindMyProduct API
# Copyright (C) 2020  00198216
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, version 3 of the License.
#
# This program is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this program. If not, see <https://www.gnu.org/licenses/>.

class ListChannel < ApplicationCable::Channel
 
#El canal que se debera suscribir la aplicacion para recibir data.
  def subscribed
     stream_from "super_channel"
  end

#que hacer cuando el usuario sale del canal
  def unsubscribed
  end

#La informacion a mandar cuando se entra a canal
  def message(data)
    @num=data['id'].to_i
    @user=User.find(@num)
    @all= List.all
    @message= 
     # Jbuilder.encode  do |json|
     #  json.info @user, :id
     # 
      Jbuilder.encode  do |json|
      json.info @all do |list|  
      json.id list.id
       json.name list.name
       json.creation list.created_at
       json.users list.users do |user|
       json.user_id user.id
       json.username user.username
       end
      json.products list.products do |product|
      json.product_id product.id
      json.product_name product.name
      @help= @association= ListProduct.find_by(
         list_id: list.id,
         product_id: product.id)
       json.product_quantity @help.quantity
       json.product_descripcion @help.description
       json.product_status @help.checked
      end
      
   end
 end
  ActionCable.server.broadcast 'super_channel', message: @message
  end

end

