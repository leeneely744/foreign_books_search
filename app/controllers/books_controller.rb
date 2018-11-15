class BooksController < ApplicationController
    def search
        @q = Book.ransack(params[:q])
        @books = @q.result(distinct: true)
    end
    
    def show
        @isbn = params[:id]
        # @book = Book.find_by(isbn: @isbn)
    end
    
    private
end
