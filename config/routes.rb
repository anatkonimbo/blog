Blog::Application.routes.draw do
root to: "posts#index"

resources :posts do
  resources :comments
end

get '/about', to: 'pages#about'



end
