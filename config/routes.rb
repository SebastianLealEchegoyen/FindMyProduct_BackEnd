Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      mount ActionCable.server => '/cable'
      resources :lists  do
        collection do
          post 'add'
        end
      end
      resources :listusers
      resources :products, only: [:show,:index,:create] 
      resources :users, only: [:create,:index,:update,:show] do
        collection do
          post 'login'
        end
        member do
          get 'lists'
        end
    end
end
end
end
