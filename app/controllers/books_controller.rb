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
    end
    
    private
        def read_param
            if params[:q]
                return params.require(:q).permit(
                    :title_cont,
                    :page_gteq,
                    :page_lteq,
                    :books_genre_id_eq
                )
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
