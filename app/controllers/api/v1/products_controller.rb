class Api::V1::ProductsController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, :with => :task_not_found
    before_action :authenticate_request!, except: [:index,:show]
    before_action :load_current_user!, only: [:create,:update]

      def index
            
        @products= Product.all

      end

      def show
        @product = Product.find_by(id: params[:id])
      end

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
        params.require(:product).permit(:name,:category,:quantity,:photo)
      end
    
end