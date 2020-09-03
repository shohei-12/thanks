Rails.application.routes.draw do
  root 'posts#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/guest_login', to: 'sessions#guest'
  delete '/logout', to: 'sessions#destroy'
  get '/posts/category/:id', to: 'posts#category', as: 'posts_category'
  get '/posts/popular', to: 'posts#popular', as: 'popular_posts'
  get '/posts/search', to: 'posts#search', as: 'search_posts'
  post '/post/like/:id', to: 'likes#post_create', as: 'post_like'
  delete '/post/unlike/:id', to: 'likes#post_destroy', as: 'post_unlike'
  post '/comment/like/:id', to: 'likes#comment_create', as: 'comment_like'
  delete '/comment/unlike/:id', to: 'likes#comment_destroy', as: 'comment_unlike'
  get '/comment/like/sort', to: 'comments#like_sort', as: 'comment_like_sort'
  resources :users
  resources :posts, except: %i[index]
  resources :relationships, only: %i[create destroy]
  resources :comments, only: %i[create destroy]
end
