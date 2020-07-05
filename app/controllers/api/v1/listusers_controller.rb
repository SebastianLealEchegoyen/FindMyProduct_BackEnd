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

class Api::V1::ListusersController < ApplicationController


    rescue_from ActiveRecord::RecordNotFound, :with => :task_not_found
    before_action :authenticate_request!

    #Elimina un usuario de una lista
    def destroy
        @user = User.find_by(id: params[:id])
        @List= List.find_by(name: params[:name])
        @association= ListUser.find_by(
          list_id: @List.id,
          user_id: @user.id
        ).destroy     
        render json: {status: "deleted friend drom the list successfully"}, status: 201
    end

    #Agrega un usuario a una lista
    def add
      @user = User.find_by(id: params[:id])
      @List= List.find_by(name: params[:name])
      @user.lists << @List
      render json: {status: "added friend to the list successfully"}, status: 201
      @lists=List.all
      @products=@List.products
      @User = @user
      @all= List.all
      @message=
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
