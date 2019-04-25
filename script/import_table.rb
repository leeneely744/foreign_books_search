# CSVの1行目にはカラム名がある
# カラム名の順番に規則性はない

require 'csv'

def castType(data, thisType)
  if data.nil? || data.empty?
    return nil
  end

  if thisType == :integer
    return data.to_i
  elsif thisType == :datetime
    return data.to_datetime
  elsif thisType == :date
    return data.to_time
  else
    return data
  end
end

books = []
bookColumnNameArray = Book.column_names
CSV.foreach('tmp/all_book.csv', headers: true) do |row|
  newBook = Book.new
  bookColumnNameArray.each do |column|
    if column == 'id' || column == 'created_at' || column == 'updated_at'
      next
    end
    thisType = Book.columns_hash[column].type
    newBook[column] = castType(row[column], thisType)
  end
  books << newBook
end
Book.import books

puts "books end !"

genres = []
genreColumnNameArray = Genre.column_names
CSV.foreach('tmp/all_genre.csv', headers: true) do |row|
  newGenre = Genre.new
  genreColumnNameArray.each do |column|
    if column == 'id' || column == 'created_at' || column == 'updated_at'
      next
    end
    thisType = Genre.columns_hash[column].type
    newGenre[column] = castType(row[column], thisType)
  end
  genres << newGenre
end
Genre.import genres

puts "genres end !"

genreGroups = []
genreGroupsColumnNameArray = GenreGroup.column_names
CSV.foreach('tmp/all_genre_group.csv', headers: true) do |row|
  newGenreGroup = GenreGroup.new
  genreGroupsColumnNameArray.each do |column|
    if column == 'id' || column == 'created_at' || column == 'updated_at'
      next
    end
    thisType = GenreGroup.columns_hash[column].type
    newGenreGroup[column] = castType(row[column], thisType)
  end
  genreGroups << newGenreGroup
end
Book.import genreGroups

puts "genreGroups end !"