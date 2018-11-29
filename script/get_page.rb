include RakutenHelper

books = Book.where(page: nil)

books.each do |book|
  puts "id = #{book.id} の書籍データを更新します。"
  page = getPageNumFromRakuten(book.item_url.to_s)
  
  if page.nil?
    page = 0
    puts '0を入れます'
  else
    puts 'page = ' + page.to_s
  end
  
  book.page = page
  book.save
end