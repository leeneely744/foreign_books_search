class BooksController < ApplicationController
    def search
        @q = Book.ransack(params[:q])
        @genres = Genre.where(genre_level: "3")
        @books = @q.result(distinct: true)
    end
    
    def show
        @id = params[:id]
        @book = Book.find(@id)
    end
    
    private
end
