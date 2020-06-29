class Api::V1::ListproductsController < ApplicationController


    rescue_from ActiveRecord::RecordNotFound, :with => :task_not_found
    before_action :authenticate_request!, except: [:show]
    before_action :load_current_user!, only: [:create,:update,:add,:update]

    #Elimina un producto de una lista
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

 #Agregar un producto a una lista
    def add
      @List = List.find_by(id: params[:id])
      @product= Product.find_by(name: params[:name])
      @List.products << @product
      @association= ListProduct.find_by(
        list_id: @List.id,
        product_id: @product.id)
      @association.update_attribute(:description, params[:description])
      @association.update_attribute(:quantity, params[:quantity])
      @association.update_attribute(:checked, false)
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

   #Actualizar un producto de una lista
    def update
      @List = List.find_by(id: params[:id])
      @product= Product.find_by(name: params[:name])
      @association= ListProduct.find_by(
        list_id: @List.id,
        product_id: @product.id)
      
      if @association.update_attribute(:quantity, params[:quantity])
        @association.update_attribute(:description, params[:description])
        render json: {status: "product quantity updated"}, status: 201
        @User = @current_user
        @all= @User.lists
        @message=
          Jbuilder.encode  do |json|
          json.info @all do |list|  
          json.id list.id
          json.name list.name
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
      else
        render :json => { :errors => @list.errors.full_messages }, status: 400
      end
  
  end

   #Marca un producto de una lista[Le aplica un marca]
  def check
    @List = List.find_by(id: params[:id])
    @product= Product.find_by(name: params[:name])
    @association= ListProduct.find_by(
      list_id: @List.id,
      product_id: @product.id)
    
    if @association.checked
      @association.update_attribute(:checked, false)
      render json: {status: "delisted product"}, status: 201
      @User = @current_user
      @all= @User.lists
      @message=
        Jbuilder.encode  do |json|
        json.info @all do |list|  
        json.id list.id
        json.name list.name
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
    else
      @association.update_attribute(:checked, true)
      render json: {status: "listed product"}, status: 201
      @User = @current_user
      @all= @User.lists
      @message=
        Jbuilder.encode  do |json|
        json.info @all do |list|  
        json.id list.id
        json.name list.name
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

 #Mostrar las listas con productos de una
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

    private
    def description_params
      params.require(:listproduct).permit(:description)
    end
end
