Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :lists
      resources :listusers
      resources :products, only: [:show,:index,:create] 
      resources :users, only: [:create,:index,:update,:show] do
        collection do
          post 'login'
        end
    end
end
end
end
