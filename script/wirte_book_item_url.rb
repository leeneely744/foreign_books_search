=begin
Bookモデルのitem_urlを全てCSVで出力する。
別のプログラムでページ数をスクレイピングするのに使う。
=end

# 「ページ数」がない書籍を全て取得
allBooks = Book.where(page: nil)

# idとitem_urlをCSVにする
rows = []
allBooks.each do |book|
    rows << book.id.to_s + "," + book.item_url
end

# rowsをファイル出力する
File.open("db/csv/booksItemUrls.csv", "w") do |f|
   rows.each do |row|
      f.puts(row) 
   end
end