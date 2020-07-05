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

Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      mount ActionCable.server => '/cable'
      resources :lists  do
        member do
          get 'products'
        end

        member do
          get 'users'
        end
     
      end
      resources :listusers do
        collection do
          post 'add'
        end
      end

      resources :listproducts do
        collection do
          post 'add'
        end
        collection do
          post 'check'
        end
      end
      resources :products, only: [:show,:index,:create,:update]  do
        collection do
          get 'search'
        end
      end
      resources :users, only: [:create,:index,:update, :show] do
        collection do
          post 'login'
          resources :friendships, only: [:index, :create, :destroy, :update]
        end

        collection do
          get 'search'
        end

        member do
          get 'lists'
        end
        #resources :frienships, only: [:create, :destroy]
    end
end
end
end
