module Types
  class QueryType < Types::BaseObject
    
    field :books, [Types::BookType], null: false do
      # "required: false" DocsでNullableと表示されるだけで、
      # 本当にNullableかどうかはresolveメソッドの引数による
      argument :page_num_from, Integer, required: false
      argument :page_num_to, Integer, required: false
      argument :limit, Integer, required: false
    end
    def books(page_num_from: 0, page_num_to: 9999, limit: 10)
      Book.all.limit(limit)
    end

    field :book, Types::BookType, null: false do
      argument :id, ID, required: true
    end
    def book(id:)
      Book.find(id)
    end
  end
end
