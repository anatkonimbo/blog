Blog::Application.routes.draw do
root to: "posts#index"

resources :posts do
  resources :comments do
     collection do
       put :showcomment
     end
   end
end

get '/about', to: 'pages#about'


end
