module Types
  class QueryType < Types::BaseObject

    field :genre_groups, [Types::GenreGroupType], null: false,
      description: 'ジャンルグループをすべて取得する'
    def genre_groups
      GenreGroup.all
    end
    
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
      description "書籍詳細を取得する"
      argument :id, ID, required: true

      # fieldと同名のResolverを用いて値を返す。
      # :book fieldは#bookメソッドを用いる
      # fieldブロック内に以下のように書くことでメソッド名をOverride出来る
      #  method: :oneBook
      # また、fieldの第3引数ニイカを渡しても同様の動きをする
      #  resolver_method: :oneBook
    end
    def book(id:)
      Book.find(id)
    end
  end
end
