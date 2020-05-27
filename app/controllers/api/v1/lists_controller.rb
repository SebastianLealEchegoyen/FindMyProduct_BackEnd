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
      ActionCable.server.broadcast 'super_channel', user: @current_user.lists

    else
      render :json => { :errors => @list.errors.full_messages }, status: :bad_request
    end
  end

  private
  def list_params
    params.require(:list).permit(:name, :quantity)
  end
end
 