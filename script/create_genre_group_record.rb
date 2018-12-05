# genresテーブルからレベル2のジャンル情報を取り出して、
# genre_groupsテーブルに新しいレコードとして保存
level2Genres = Genre.where(genre_level: 2)
level2Genres.each do |genre|
  # 重複を避けるため「なければ作る」メソッドを使用
  GenreGroup.find_or_create_by(
    books_genre_id: genre.books_genre_id,
    books_genre_name: genre.books_genre_name,
    genre_level: genre.genre_level
    )
end

# genre_groups.genre_groups_idをgenre.genre_groups_idにupdate
genreGroups = GenreGroup.all
genreGroups.each do |group|
  Genre.where(
    'books_genre_id like ?', group.books_genre_id + "%"
    ).update(genre_group_id: group.id)
end
