
class Api::V1::ListproductsController < ApplicationController

    def destroy
        @List = List.find_by(id: params[:id])
        @product= Product.find_by(name: params[:name])   
        @association= ListProduct.find_by(
          list_id: @List.id,
          product_id: @product.id
        ).destroy
         render json: { message: "Product succesfully removed from list" }, status: 200
      
end
end
