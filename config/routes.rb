Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      mount ActionCable.server => '/cable'
      resources :lists  do
        member do
          get 'products'
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
