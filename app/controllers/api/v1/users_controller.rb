class Api::V1::UsersController < ApplicationController

            rescue_from ActiveRecord::RecordNotFound, :with => :task_not_found
            before_action :authenticate_request!, except: [:login,:create]

  #Muestra todos los usuarios
    def index
            
        @users= User.all
        #puts @users.friends


      end

#Crea un usuario
      def create
        @user = User.new(user_params)
         if(@user.is_Admin==nil)
             @user.is_Admin=false
         end
        if @user.save
          render json: {status: "User created successfully"}, status: 201
        else
          render :json => { :errors => @user.errors.full_messages }, status: :bad_request
        end
      end
    
      #Login
      def login
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
          token = JsonWebToken.encode({user_id: @user.id})
          render json: {Bearer: token, User_id:@user.id}, status: :ok
        else
          render json: {error: 'Invalid email / password'}, status: :unauthorized
        end
      end

      #Mostrar un usuario
      def show
        @user = User.find_by(id: params[:id])
        #@confirmed_friends = User.confirmed_friends(@current_user)
        #@pending_friends = User.pending_friends(@current_user)
        #@requested_friends = User.requested_friends(@current_user)
        #puts @current_user.friend?(@user)
      end

      #Mostrar las listas de un usuario
      def lists
        @user = User.find_by(id: params[:id])
        
      end

      #Buscar un usuario
      def search
        @query=User.all
        if params[:filter]
          @query = User.search_name(params[:filter])
        end
        
      end
    
      private
      def user_params
        params.require(:user).permit(:username, :password, :email, :phone, :photo,:is_Admin)
      end

      private
      def id_params
        params.require(:user).permit(:id)
      end
  
    end 
