puts 'script start'

def createRow(columnNameArray, record)
  row = ''
  columnNameArray.each do |column|
    if column == 'id' || column == 'created_at' || column == 'updated_at'
      next
    end

    data = record[column]
    if data.is_a? NilClass
      row += '' + ','
    elsif data.is_a? String
      data.gsub!(/[\r\n]/,"")
      data.gsub!(/[\r]/,"")
      data.gsub!(/[\n]/,"")
      data.gsub!(/["]/,"'")
      row += '"' + data + '",'
    else
      row += data.to_s + ','
    end
  end
  return row.chop!
end

def createHeader(datas)
  header = ''
  datas.each do |column|
    if column == 'id' || column == 'created_at' || column == 'updated_at'
      next
    end

    header += column + ','
  end
  return header.chop!
end

puts "books start"

# Book csv
books = Book.all
bookColumnNameArray = Book.column_names
File.open("tmp/all_book.csv", "w") do |f|
  # ヘッダー行
  f.puts(createHeader(bookColumnNameArray))

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
  f.puts(createHeader(genreColumnsNameArray))

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
  f.puts(createHeader(genreGroupColumnsNameArray))

  genreGroups.each do |genreGroup|
    row = createRow(genreGroupColumnsNameArray, genreGroup)
    f.puts(row)
    # break
  end
end