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

class Api::V1::ProductsController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, :with => :task_not_found
    before_action :authenticate_request!, except: [:index,:show]
    before_action :load_current_user!, only: [:create,:update]

    #Muestra todos los productos
      def index
            
        @products= Product.all

      end

    #Muestra un producto
      def show
        @product = Product.find_by(id: params[:id])
      end

         #Buscar un product
         def search
          @query=Product.all
          if params[:filter]
            @query = Product.search_name(params[:filter])
          end
          
        end

      #Crear un producto (Admin only)
      def create
        if @current_user.is_Admin?
        @product = Product.new(product_params)
        if @product.save
          render json: {status: "Product created successfully"}, status: 201
          #ActionCable.server.broadcast 'super_channel', user: @current_user.lists
    
        else
          render :json => { :errors => @product.errors.full_messages }, status: :bad_request
        end
      end
    end

    #Actualiza un producto (Admin only)
    def update
    
        if @current_user.is_Admin?
        @Product=Product.find_by(id: params[:id])
  
        if @Product.update(product_params)
          render json: {status: "product updated"}, status: 201
        else
          render :json => { :errors => @product.errors.full_messages }, status: 400
        end
    end
    
    end

      private
      def product_params
        params.require(:product).permit(:name,:category)
      end
    
end