require "csv"
require "open-uri"

include RakutenHelper
include GenresHelper

def codeIs200?(code, message)
    if code == '200'
        return true
    else
        puts 'ジャンルの取得に失敗しました: ' + code
        puts message
        return false
    end
end

genreArray = []
res = requestToGSApiByGenreId('005')
code, message = res.status

if codeIs200?(code, message) == false
    return
end

# level2のジャンル情報を取りだす
level2GenreArray = []
childrenJson = getCheldren(JSON.parse(res.read))
childrenJson.each do |childJson|
    newGenre = createGenreEntity(getChild(childJson))
    level2GenreArray << newGenre
end

# level3のジャンル情報を取得
level2GenreArray.each do |genre|
    sleep(2)
    res = requestToGSApiByGenreId(genre.books_genre_id)
    code, message = res.status
    if codeIs200?(code, message) == false
        return
    end
    
    puts "\n" + genre.books_genre_name
    childrenJson = getCheldren(JSON.parse(res.read))
    childrenJson.each do |childJson|
        newGenre = createGenreEntity(getChild(childJson))
        puts newGenre.books_genre_name
        genreArray << newGenre
    end
end

# level2のジャンル情報も一応持っておく
genreArray.concat(level2GenreArray)

Genre.import genreArray

# bookArray = []
# outputCsv = CSV.open("db/csv/outputCsv.csv", 'w')
# CSV.foreach('db/csv/bookData.csv', headers: true) do |data|
#     sleep(2)
#     puts ($.).to_s + "番目の要素です: #{data["isbn"]}"
    
#     res = requestToRBOSApiByIsbn(data["isbn"])
#     code, message = res.status
    
#     if code != '200'
#         puts 'ステータス異常でseedを中断します: ' + code
#         puts message
#         break
#     end
    
#     resJson = JSON.parse(res.read)
    
#     bookCount = countItems(resJson)
#     if bookCount > 1
#         puts bookCount.to_s + "個の書籍が該当しました"
#         outputCsv.puts [bookCount, data["isbn"]]
#         next
#     elsif bookCount == 0
#         puts "該当する書籍がありませんでした"
#         outputCsv.puts [bookCount, data["isbn"]]
#         next
#     end
    
#     bookInfo = getItemInfo(resJson)
    
#     newBook = createBookEntity(bookInfo)
    
#     if newBook.isbn.empty? || newBook.title.empty?
#         puts 'isbnかtitleが空なのでスキップします'
#         next
#     end
    
#     # CSVに入れておいたデータを入れる
#     newBook["vocabulary"] = data["vocabulary"]
#     newBook["page"] = data['page']
#     newBook['official_url'] = data['official_url']
    
#     bookArray << newBook
# end

# outputCsv.close

# puts 'bookArray.length = ' + bookArray.length.to_s
# Book.import bookArray

puts 'finish !'