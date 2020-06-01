class Api::V1::ListproductsController < ApplicationController


    rescue_from ActiveRecord::RecordNotFound, :with => :task_not_found
    before_action :authenticate_request!, except: [:show]
    before_action :load_current_user!, only: [:create,:update,:add,:update]

    def destroy
        @List = List.find_by(id: params[:id])
        @product= Product.find_by(name: params[:name])   
        @association= ListProduct.find_by(
          list_id: @List.id,
          product_id: @product.id
        ).destroy
        @List.quantity=@List.quantity-1
        @List.update_attribute(:quantity, @List.quantity)
         render json: { message: "Product succesfully removed from list" }, status: 200
         @User = @current_user
         @all= @User.lists
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
    def add
      @List = List.find_by(id: params[:id])
      @product= Product.find_by(name: params[:name])
      @List.products << @product
      @association= ListProduct.find_by(
        list_id: @List.id,
        product_id: @product.id)
      @association.update_attribute(:quantity, params[:quantity])
      puts(@association.quantity)
      @List.quantity=@List.quantity+1
      @List.update_attribute(:quantity, @List.quantity)
      render json: {status: "added product successfully"}, status: 201
      @lists=List.all
      @products=@List.products
      @User = @current_user
      @all= @User.lists
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

    def update
      @List = List.find_by(id: params[:id])
      @product= Product.find_by(name: params[:name])
      @association= ListProduct.find_by(
        list_id: @List.id,
        product_id: @product.id)
      
      if @association.update_attribute(:quantity, params[:quantity])
        render json: {status: "product quantity updated"}, status: 201
        @User = @current_user
        @all= @User.lists
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
