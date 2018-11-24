module RakutenHelper

  @@foreignBookGenreId = '005'
  
  def getCheldren(apiRes)
    apiRes['children']
  end
  
  def getChild(children)
    children['child']
  end
  
  # 楽天ブックスジャンル検索APIから、
  # 指定されたジャンルID以下のジャンル情報を全て取得する。
  # genreIdに何も指定されなければ「洋書」以下を取得する。
  # JSON.parse(res.read) でパースする必要がある
  def requestToGSApiByGenreId(genreId = @@foreignBookGenreId)
    url = 'https://app.rakuten.co.jp/services/api/BooksGenre/Search/20121128' +
    '?format=json' +
    '&booksGenreId=' + genreId +
    '&applicationId=' + ENV["RAKUTEN_APPLY_ID"]
    
    open(url)
  end
  
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
  
  # 楽天ブックス総合検索APIに問い合わせた結果を文字列で得る
  # JSON.parse(res.read) でパースする必要がある
  # RBOSApi : Rakuten Books Overall Search Api
  def requestToRBOSApiByIsbn(isbn)
    url = 'https://app.rakuten.co.jp/services/api/BooksTotal/Search/20170404' +
    '?format=json' +
    '&isbnjan=' + isbn +
    '&affiliateId=' + ENV["RAKUTEN_AFFILIATE_ID"] +
    '&applicationId=' + ENV["RAKUTEN_APPLY_ID"]
    
    # 'code, message = res.status'でstatusCodeを確認してから処理すること
    open(url)
  end
  
  # 楽天APIからのレスポンスに何件の書籍情報があるか
  def countItems(json)
    json['count']
  end
  
  # 1件の書籍情報を取得
  def getItemInfo(json)
    json['Items'][0]["Item"]
  end
end