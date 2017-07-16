Blog::Application.routes.draw do

resources :posts do
  resources :comments
end
  root to: "posts#index"


get '/about', to: 'pages#about'

end
