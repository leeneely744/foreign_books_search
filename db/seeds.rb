require "csv"
require "open-uri"

include RakutenHelper

# バルクインサートはPostgres9.5+ でしか使えないので、そのうちバージョンアップする
# 最初の一行はヘッダー行
bookArray = []
outputCsv = CSV.open("db/csv/outputCsv.csv", 'w')
CSV.foreach('db/csv/bookData.csv', headers: true) do |data|
    sleep(2)
    puts ($.).to_s + "番目の要素です: #{data["isbn"]}"
    
    res = requestToRBOSApiByIsbn(data["isbn"])
    code, message = res.status
    
    if code != '200'
        puts 'ステータス異常でseedを中断します: ' + code
        puts message
        break
    end
    
    resJson = JSON.parse(res.read)
    
    bookCount = countItems(resJson)
    if bookCount > 1
        puts bookCount.to_s + "個の書籍が該当しました"
        outputCsv.puts [bookCount, data["isbn"]]
        next
    elsif bookCount == 0
        puts "該当する書籍がありませんでした"
        outputCsv.puts [bookCount, data["isbn"]]
        next
    end
    
    bookInfo = getItemInfo(resJson)
    
    newBook = createBookEntity(bookInfo)
    
    if newBook.isbn.empty? || newBook.title.empty?
        puts 'isbnかtitleが空なのでスキップします'
        next
    end
    
    # CSVに入れておいたデータを入れる
    newBook["vocabulary"] = data["vocabulary"]
    newBook["page"] = data['page']
    newBook['official_url'] = data['official_url']
    
    bookArray << newBook
end

outputCsv.close

puts 'bookArray.length = ' + bookArray.length.to_s
Book.import bookArray

puts 'finish !'