class BooksController < ApplicationController
    def search
        @q = Book.ransack(params[:q])
        @books = @q.result(distinct: true)
    end
    
    private
end
