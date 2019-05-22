Rails.application.routes.draw do
  get '/search', to: 'books#search'
  get '/help',  to: 'static_pages#help'
  get '/about', to: 'static_pages#about' # about_path
  get '/home',  to: 'static_pages#home'
  root 'books#search'
  
  # rake routes コマンドでルート一覧を確認すると、
  # '/books/:id'でbooks#showにアクセスできることがわかる
  resources :books
  
end
