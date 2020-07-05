# FindMyProduct API
# Copyright (C) 2020  00198216
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, version 3 of the License.
#
# This program is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this program. If not, see <https://www.gnu.org/licenses/>.

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
