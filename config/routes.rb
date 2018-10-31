Rails.application.routes.draw do
  root 'static_pages#home'
  
  get '/help',  to: 'static_pages#help'
  get '/about', to: 'static_pages#about' # static_pages_about_url
  
  get '/search', to: 'books#search'
  
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
