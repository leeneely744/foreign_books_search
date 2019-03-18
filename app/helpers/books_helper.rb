module BooksHelper
  # JsonデータからBookエンティティを作成する
  def createBookEntity(bookJson)
    newBook = Book.new
    for key, value in bookJson do
      if Book.has_attribute?(key.underscore)
        newBook[key.underscore] = value
      end
    end
    return newBook
  end

  def createAuthorString(enAuthor, jaAuthor=nil)
    if jaAuthor.nil?
      return "著者名: " + enAuthor
    end
    return "著者名: " + enAuthor + " ( 日本名: " + jaAuthor + " )"
  end

  def getJaTitle(jaTitle)
    if jaTitle == ''
      return ''
    end
    return "日本語タイトル: " + jaTitle
  end

  def getGenre(genre, group)
    if genre.nil? || group.nil?
      return "ジャンル不明"
    end
    return "ジャンル: " + genre + " / " + group
  end
end
