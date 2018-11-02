class BooksController < ApplicationController
    def search
        puts params[:title]
    end
end
