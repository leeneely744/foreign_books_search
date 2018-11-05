module RakutenHelper
  # 楽天ブックス総合検索APIに問い合わせする
  # RBOSApi : Rakuten Books Overall Search Api
  def requestToRBOSApiByIsbn(isbn)
    url = 'https://app.rakuten.co.jp/services/api/BooksTotal/Search/20170404' +
    '?format=json' +
    '&isbnjan=' + isbn +
    '&affiliateId=' + ENV["RAKUTEN_AFFILIATE_ID"] +
    '&applicationId=' + ENV["RAKUTEN_APPLY_ID"]
    
    res = open(url)
    return JSON.parse(res.read)
  end
  
  # 楽天APIからのレスポンスに何件の書籍情報があるか
  def countItems(json)
    json['count']
  end
  
  # 1件の書籍情報を取得
  def getItemInfo(json)
    return json['Items'][0]["Item"]
  end
end