class BooksController < ApplicationController
  
  # 書籍検索で使用するパラメータ
  @@queryParam = []

  def search
    @q = Book.ransack(read_param)
    @genreGroups = GenreGroup.all
    @books = @q.result(distinct: true)
    .paginate(page: params[:page], :per_page => 20)

    write_param(params[:q])
    
    # ランダム検索で使用する本のid
    # idは0から始まるとは限らず、連続しているとも限らない
    @randomId = Book
    .select('id')
    .where('id >= ?', rand(Book.first.id..Book.last.id))
    .first
  end
  
  def show
    @id = params[:id]
    @book = Book.find(@id)

    genreId = @book.books_genre_id.to_s
    groupId = genreId[0..5]
    @genreName = Genre.find_by(books_genre_id: genreId).books_genre_name
    @groupName = GenreGroup.find_by(books_genre_id: groupId).books_genre_name

    @rakutenUrl = getRakutenUrl(@book)
  end
  
  private
    def getRakutenUrl(book)
      if book.affiliate_url.blank?
        return book.item_url
      end
      return book.affiliate_url
    end

    def strong_parameter(params_q)
      params_q[:q]['page_gteq'] = page_num_check(params_q[:q]['page_gteq'])
      params_q[:q]['page_lteq'] = page_num_check(params_q[:q]['page_lteq'])
      params_q[:q]['books_genre_id_eq'] = books_genre_id_check(params_q[:q]['books_genre_id_eq'])
      params_q.require(:q).permit(
        :s, # sort_link のパラメータ
        :title_cont,
        :page_gteq,
        :page_lteq,
        :books_genre_id_eq
      )
    end

    def page_num_check(input_num)
      return "" if input_num.empty?
      if input_num.to_i < -9999 || 9999 < input_num.to_i || input_num.to_i == 0
        return 0
      end
      return input_num
    end

    def books_genre_id_check(input_num)
      return "" if input_num.empty? || input_num.size > 9
      return input_num
    end

    def read_param
      if params[:q]
        return strong_parameter(params)
      elsif @@queryParam.class == ActionController::Parameters
        return @@queryParam
      else
        return []
      end
    end

    def write_param(params)
      if params.class == ActionController::Parameters
        @@queryParam = params
      end
    end
end
