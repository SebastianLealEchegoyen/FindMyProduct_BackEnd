json.friends @user.friendships do |friendship|
  json.friendship_id friendship.id
  json.user_id friendship.friend.id
  json.username friendship.friend.username
end

json.inverse_friends @user.inverse_friendships do |inverse_friendship|
  json.friendship_id inverse_friendship.id
  json.user_id inverse_friendship.user.id
  json.username inverse_friendship.user.username
end

json.pending_friends @user.pending_friendships do |pending_friendship|
  json.friendship_id pending_friendship.id
  json.user_id pending_friendship.friend.id
  json.username pending_friendship.friend.username
end

json.friend_requests @user.requested_friendships do |requested_friendship|
  json.friendship_id requested_friendship.id
  json.user_id requested_friendship.user.id
  json.username requested_friendship.user.username
end