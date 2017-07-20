Blog::Application.routes.draw do
get 'tags/:tag', to: 'posts#index', as: :tag

resources :posts do
  resources :comments
end
  root to: "posts#index"


get '/about', to: 'pages#about'


end
