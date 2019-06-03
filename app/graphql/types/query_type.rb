module Types
  class QueryType < Types::BaseObject

    field :genre_groups, [Types::GenreGroupType], null: false,
      description: 'ジャンルグループをすべて取得する'
    def genre_groups
      begin
        GenreGroup.all
      rescue => exception
        raise GraphQL::ExecutionError, exception.message
      end
    end
    
    field :books, [Types::BookType], null: false do
      # "required: false" DocsでNullableと表示されるだけで、
      # 本当にNullableかどうかはresolveメソッドの引数による
      argument :page_num_from, Integer, required: false, default_value: 0, prepare: :check_page_num
      argument :page_num_to, Integer, required: false, default_value: 9999, prepare: :check_page_num
      argument :limit, Integer, required: false, default_value: 10, prepare: ->(limit, ctx) {[limit, 30].min}
    end
    def books(page_num_from: , page_num_to: , limit: )
      begin
        Book.all.limit(limit)
      rescue => exception
        raise GraphQL::ExecutionError, exception.message
      end
    end

    field :book, Types::BookType, null: false do
      description "書籍詳細を取得する"
      argument :id, ID, required: true, prepare: :check_num

      # fieldと同名のResolverを用いて値を返す。
      # :book fieldは#bookメソッドを用いる
      # fieldブロック内に以下のように書くことでメソッド名をOverride出来る
      #  method: :oneBook
      # また、fieldの第3引数に以下を渡しても同様の動きをする
      #  resolver_method: :oneBook
    end
    def book(id:)
      begin
        book = Book.find(id)
      rescue => e
        raise GraphQL::ExecutionError, "書籍が見つかりません"
      end
    end


    # ここから先はprivateとして扱う
    # 実際にprivateをprepareに渡すとエラーになる

    def check_page_num(page_num)
      page_num = 9999 if page_num > 9999
      page_num = 0 if page_num < 0
      page_num
    end

    def check_num(input)
      input.to_i
    end
  end
end
