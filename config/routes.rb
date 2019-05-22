Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  get '/search', to: 'books#search'
  get '/help',  to: 'static_pages#help'
  get '/about', to: 'static_pages#about' # about_path
  get '/home',  to: 'static_pages#home'
  root 'books#search'
  
  # rake routes コマンドでルート一覧を確認すると、
  # '/books/:id'でbooks#showにアクセスできることがわかる
  resources :books
  
end
