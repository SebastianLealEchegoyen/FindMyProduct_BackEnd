
class Api::V1::ListproductsController < ApplicationController

    def destroy
        @List = List.find_by(id: params[:id])
        @product= Product.find_by(name: params[:name])   
        @association= ListProduct.find_by(
          list_id: @List.id,
          product_id: @product.id
        ).destroy
         render json: { message: "Product succesfully removed from list" }, status: 200
         @lists=List.all
         ActionCable.server.broadcast 'super_channel', message: @lists
         @products=@List.products
         ActionCable.server.broadcast 'luci_channel', message: @products
      
end
    def add
      @List = List.find_by(id: params[:id])
      @product= Product.find_by(name: params[:name])
      @List.products << @product
      @association= ListProduct.find_by(
        list_id: @List.id,
        product_id: @product.id)
      @association.quantity=params[:quantity]
      @association.save()
      puts(@association.quantity)

      render json: {status: "added product successfully"}, status: 201
      @lists=List.all
      @products=@List.products
      ActionCable.server.broadcast 'super_channel', message: @lists
      ActionCable.server.broadcast 'luci_channel', message: @products
    end

    def update
      @List = List.find_by(id: params[:id])
      @product= Product.find_by(name: params[:name])
      @association= ListProduct.find_by(
        list_id: @List.id,
        product_id: @product.id)
      
      if @association.update_attribute(:quantity, params[:quantity])
        render json: {status: "product quantity updated"}, status: 201
      else
        render :json => { :errors => @list.errors.full_messages }, status: 400
      end
  
  end

  def show
    @User = User.find_by(id: params[:id])
    @List= @User.lists

  end

 

    private
    def list_params
      params.require(:list).permit(:id)
    end
  
    private
    def product_params
      params.require(:product).permit(:name)
    end

    private
    def quantity_params
      params.require(:listproduct).permit(:quantity)
    end
end
