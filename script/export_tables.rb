puts 'script start'

def createRow(columnNameArray, record)
  row = ''
  columnNameArray.each do |column|
    data = record[column]
    if data.is_a? NilClass
      row += '' + ','
    elsif data.is_a? String
      data.gsub!(/[\r\n]/,"")
      data.gsub!(/[\r]/,"")
      data.gsub!(/[\n]/,"")
      row += '"' + data + '",'
    else
      row += data.to_s + ','
    end
  end
  return row.chop!
end

puts "books start"

# Book csv
books = Book.all
bookColumnNameArray = Book.column_names
File.open("tmp/all_book.csv", "w") do |f|
  # ヘッダー行
  f.puts(bookColumnNameArray.to_sentence(words_connector: ","))

  books.each do |book|
    row = createRow(bookColumnNameArray, book)
    f.puts(row)
    # break
  end
end

puts "genres start"

# Genre csv
genres = Genre.all
genreColumnsNameArray = Genre.column_names
File.open("tmp/all_genre.csv", "w") do |f|
  # ヘッダー行
  f.puts(genreColumnsNameArray.to_sentence(words_connector: ","))

  genres.each do |genre|
    row = createRow(genreColumnsNameArray, genre)
    f.puts(row)
    # break
  end
end

puts "genreGroups start"

# GenreGrouop csv
genreGroups = GenreGroup.all
genreGroupColumnsNameArray = GenreGroup.column_names
File.open("tmp/all_genre_group.csv", "w") do |f|
  # ヘッダー行
  f.puts(genreGroupColumnsNameArray.to_sentence(words_connector: ","))

  genreGroups.each do |genreGroup|
    row = createRow(genreGroupColumnsNameArray, genreGroup)
    f.puts(row)
    # break
  end
end