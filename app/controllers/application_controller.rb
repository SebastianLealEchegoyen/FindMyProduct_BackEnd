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

class ApplicationController < ActionController::API
    require 'jsonwebtoken'

    # Validates the token and user and sets the @current_user scope
    def authenticate_request!
      if !payload || !JsonWebToken.valid_payload(payload.first)
        return invalid_authentication
      end
      load_current_user!
      invalid_authentication unless @current_user
    end
  
    # Returns 401 response. To handle malformed / invalid requests.
    def invalid_authentication
      render json: {error: 'Unauthorized'}, status: :unauthorized
    end
  
    private
    # Deconstructs the Authorization header and decodes the JWT token.
    def payload
      auth_header = request.headers['Authorization']
      #auth_header = request.headers['Bearer']
      token = auth_header.split(' ').last
      JsonWebToken.decode(token)
    rescue
      nil
    end
  
    # Sets the @current_user with the user_id from payload
    def load_current_user!
      @current_user = User.find_by(id: payload[0]['user_id'])
    end

  
end
