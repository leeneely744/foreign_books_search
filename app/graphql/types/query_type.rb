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
      argument :title, String, required: false, default_value: '', prepare: :check_title
      argument :books_genre_id, [String], required: false, default_value: [], prepare: :check_books_genre_id
      argument :page_num_from, Integer, required: false, default_value: 0, prepare: :check_page_num
      argument :page_num_to, Integer, required: false, default_value: 9999, prepare: :check_page_num
      argument :limit, Integer, required: false, default_value: 100
    end
    def books(title: , books_genre_id: , page_num_from: , page_num_to: , limit: )
      begin
        query_hash = {
          title: add_percent(title),
          books_genre_id: books_genre_id,
          page: page_num_from..page_num_to
        }
        search_books_with_query(query_hash, limit)
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

    def add_percent(value)
      if value != ''
        return "%#{value}%"
      end
      return value
    end
    
    def search_books_with_query(query_array, limit)
      if query_array.length == 0
        return Book.limit(limit)
      end

      if query_array[:books_genre_id] == []
        query_array.delete(:books_genre_id)
      end
      
      books = Book.all
      # titleはLIKE検索したいので、ここでWHEREに付け足す
      books, query_array = add_like_argument(books, query_array, "title")
      books.where(query_array).limit(limit)
    end

    def add_like_argument(model, query_array, argument_string)
      value = query_array[argument_string.to_sym]
      if value != ''
        model = model.where("#{argument_string} like ? ", value)
      end
      query_array.delete(argument_string.to_sym)

      return model, query_array
    end

    def check_title(title)
      result = Regexp.escape(title)
      result[0, 20]
    end

    def check_books_genre_id(books_genre_ids)
      return books_genre_ids.map{|id| id.slice(0, 9)}
    end

    def check_page_num(page_num)
      page_num = 9999 if page_num > 9999
      page_num = 0 if page_num < 0
      page_num = 0 if page_num ===nil
      page_num
    end

    def check_num(input)
      input.to_i
    end
  end
end
