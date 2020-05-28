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
end