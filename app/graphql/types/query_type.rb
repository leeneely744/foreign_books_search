module Types
  class QueryType < Types::BaseObject
    
    # not null, but may be empty
    field :books, [Types::BookType], null: false
    def books
      Book.all
    end

    field :book, Types::BookType, null: false do
      argument :id, ID, required: true
    end
    def book(id:)
      Book.find(id)
    end
  end
end
