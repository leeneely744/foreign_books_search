groups = GenreGroup.all
groups.each do |group|
  Genre.where('books_genre_id like ?', group.books_genre_id + "%").
  update(genre_group_id: group.id)
end