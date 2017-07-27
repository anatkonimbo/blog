Blog::Application.routes.draw do

get 'tags/:tag', to: 'posts#index', as: :tag

root to: "posts#index"


resources :posts do
  resources :comments
end

get '/about', to: 'pages#about'
get '/change_language', to: "posts#change_language"
end
