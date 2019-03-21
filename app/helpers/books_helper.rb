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

  def getPageNum(pageNum)
    if pageNum.nil?
      return "ページ数: 不明"
    end
    return "ページ数: " + pageNum.to_s + "p"
  end

  def getReviewAve(reviewAve)
    if reviewAve.nil?
      return "レビュー平均: 不明"
    end
    return "レビュー平均: " + reviewAve
  end

  def getReviewNum(reviewNum)
    if reviewNum.nil?
      return "レビューなし"
    end
    return "レビュー数: " + reviewNum.to_s
  end
end
