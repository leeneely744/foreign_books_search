class BooksController < ApplicationController
    def search
        @q = Book.ransack(params[:q])
        @genreGroups = GenreGroup.all
        @books = @q.result(distinct: true)
        
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
end
