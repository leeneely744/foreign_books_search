include RakutenHelper

books = Book.where(page: nil)

books.each do |book|
  puts "id = #{book.id} の書籍データを更新します。"
  
  page = getPageNumFromRakuten(book.item_url.to_s)
  
  puts 'page = ' + page.to_s
  
  book.page = page
  book.save
end