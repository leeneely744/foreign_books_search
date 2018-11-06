module RakutenHelper
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