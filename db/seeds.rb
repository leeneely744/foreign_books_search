require "csv"
require "open-uri"

include RakutenHelper
include GenresHelper
include BooksHelper

def codeIs200?(code, message)
    if code == '200'
        return true
    else
        puts 'データの取得に失敗しました: ' + code
        puts message
        return false
    end
end

# genreArray = []
# res = requestToGSApiByGenreId('005')
# code, message = res.status

# if codeIs200?(code, message) == false
#     return
# end

# # level2のジャンル情報を取りだす
# level2GenreArray = []
# childrenJson = getCheldren(JSON.parse(res.read))
# childrenJson.each do |childJson|
#     newGenre = createGenreEntity(getChild(childJson))
#     level2GenreArray << newGenre
# end

# # level3のジャンル情報を取得
# level2GenreArray.each do |genre|
#     sleep(2)
#     res = requestToGSApiByGenreId(genre.books_genre_id)
#     code, message = res.status
#     if codeIs200?(code, message) == false
#         return
#     end
    
#     puts "\n" + genre.books_genre_name
#     childrenJson = getCheldren(JSON.parse(res.read))
#     childrenJson.each do |childJson|
#         newGenre = createGenreEntity(getChild(childJson))
#         puts newGenre.books_genre_name
#         genreArray << newGenre
#     end
# end

# # level2のジャンル情報も一応持っておく
# genreArray.concat(level2GenreArray)

# Genre.import genreArray

bookArray = []
genreList = Genre.where(["genre_level = ?", 3])

genreList.each do |genre|
    puts "id: #{genre.id} genre = #{genre.books_genre_name}"
   sleep(2)
   res = requestToRBFBApi(
       genre.books_genre_id,
       "reviewCount",
       ENV["RAKUTEN_APPLY_ID"],
       ENV["RAKUTEN_AFFILIATE_ID"],
       )
    code, message = res.status
       
    if codeIs200?(code, message) == false
        return
    end
    
    # Itemsの中からすべてのItemを取り出して、Bookエンティティを作成する
    items = getItems(JSON.parse(res.read))
    items.each do |data|
        newBook = createBookEntity(getItemInfo(data))
        bookArray << newBook
    end
    
    # break
end

puts 'bookArray.length = ' + bookArray.length.to_s
Book.import bookArray

puts 'finish !'