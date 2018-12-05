class BooksController < ApplicationController
    def search
        @q = Book.ransack(params[:q])
        @genreGroups = GenreGroup.all
        @books = @q.result(distinct: true)
    end
    
    def show
        @id = params[:id]
        @book = Book.find(@id)
    end
    
    private
end
