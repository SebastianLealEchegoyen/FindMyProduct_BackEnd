class Api::V1::FriendshipsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :friendship_not_found
  before_action :authenticate_request!
  before_action :load_current_user!
  before_action :set_friendship, only: [:update, :destroy]

  #Muestra las amistades del usuario.
  def index
    @user = @current_user
  end

  #Enviar solicitud de amistad.
  def create
    @other_user = User.find(params[:friend_id])
    if @current_user.friend?(@other_user) || @current_user.id == @other_user.id
      render json: { message: "already friends with this user" }, status: 400
    elsif @current_user.pending?(@other_user)
      render json: { message: "there's already a pending request" }, status: 400
    else 
      @friendship = @current_user.friendships.build(:friend_id => params[:friend_id], :confirmed => false)
      if @friendship.save
        render json: { message: "friend request sent" }, status: 201
      else
        render json: { message: "unable to add friend" }, status: 400
      end
    end
  end
 
  #Aceptar la solicitud de amigo/
  def update
    @other_user = User.find(params[:friend_id])
    if @current_user.requested_friends.include?(@other_user)
      @friendship.confirmed = true
      if @friendship.save
        render json: { message: "you are now friends" }, status: 201
      else
        render json: { message: "unable to add friend" }, status: 400
      end
    else
      render json: { message: "you must recieve a request to accept a friend" }, status: 400
    end
  end

  #Eliminar amigo o solicitud de amigo
  def destroy
    if @friendship.destroy
      render json: { message: "friendship successfully deleted." }, status: 200
    else 
      friendship_not_found
    end
  end

  private
  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  def friendship_not_found 
    render json: {error: "not found."}, status: 404
  end

end
