#json.user do
#   @user, :id, :username, :password, :email, :phone, :photo
#end

#json.friendss @user.friends
json.user do
  json.id @user.id
  json.attributes do
    json.username @user.username
    json.email @user.email
    json.phone @user.phone
    json.photo @user.photo
  end
  json.friends @confirmed_friends
  json.pending_friends @pending_friends
  json.requested_friends @requested_friends
end
