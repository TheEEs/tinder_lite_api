Rails.application.routes.draw do
  scope '/api', defaults:{format: :json} do 
    resources :matches, except: [:create,:update]
    get '/likes' => 'likes#index'
    post '/like/:id' =>  'likes#create'
    resources :users, except: [:update,:show,:destroy]
    delete "/user" => "users#destroy"
    patch "/users" => "users#update"
    get "/user" => "users#show"
    post 'token/add/:token' => 'token#add'
    delete 'token/remove/:token' => 'token#remove'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
