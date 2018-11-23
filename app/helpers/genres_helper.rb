module GenresHelper
  # 楽天ブックスジャンル検索APIのレスポンスのchild(Json)から
  # Genreエンティティを作成する
  def createGenreEntity(child)
    newGenre = Genre.new
    for key, value in child do
      if Genre.has_attribute?(key.underscore)
        newGenre[key.underscore] = value
      end
    end
    return newGenre
  end
end