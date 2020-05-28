class Api::V1::ListsController < ApplicationController
   
            rescue_from ActiveRecord::RecordNotFound, :with => :task_not_found
            before_action :authenticate_request!, except: [:index]
            before_action :load_current_user!, only: [:create]

    def index
            
        @lists= List.all


      end

def create
    @list = List.new(list_params)
    @current_user.lists << @list
    if @list.save
      render json: {status: "List created successfully"}, status: 201
      #ActionCable.server.broadcast 'super_channel', user: @current_user.lists

    else
      render :json => { :errors => @list.errors.full_messages }, status: :bad_request
    end
  end

  def add
    @List = List.find_by(id: params[:id])
    @product= Product.find_by(name: params[:name])
    @List.products << @product
    render json: {status: "added product successfully"}, status: 201
  end

  def destroy
    @List= List.find(params[:id])
    if @List.destroy
      render json: { message: "List Successfully Deleted." }, status: 200
    else
      list_not_found
    end
 
  end


  private
  def list_params
    params.require(:list).permit(:name, :quantity)
  end


  private
  def product_params
    params.require(:product).permit(:name)
  end
 
end
 