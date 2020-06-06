#json.user do
#   @user, :id, :username, :password, :email, :phone, :photo
#end

#json.friendss @user.friends
json.user do
  json.id @user.id
 
    json.username @user.username
    json.email @user.email
    json.phone @user.phone
    json.lists @user.lists

end
