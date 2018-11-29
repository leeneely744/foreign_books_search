module RakutenHelper

  require 'open-uri'
    
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
  
  # 指定されたURLから「ページ数」を取得する
  # URLは楽天APIのitem_urlにのみ対応
  # パース速度が遅すぎてseeds.rbでは使えないが、一応残しておく。
  # TODO Oga,もしくはOxをNokogiriの代わりに使う
  def getPageNumFromRakuten(url)
    doc = Nokogiri::HTML(open(url))
    doc.xpath('//li[@class="productInfo"]').each do |info|
      if info.css('span[@class="category"]').text == 'ページ数'
        return info.css('span[@class="categoryValue"]').text
      end
    end
  end
  
  # 楽天ブックス洋書検索APIに問い合わせる
  # 一度に30件までのデータしか取れない
  # genreId:ジャンルID
  def requestToRBFBApi(genreId, sort, applicationId, affiliateId)
    url = "https://app.rakuten.co.jp/services/api/BooksForeignBook/Search/20170404" +
    "?format=json" +
    "&booksGenreId=" + genreId +
    "&sort=" + sort +
    "&applicationId=" + applicationId +
    "&affiliateId=" + affiliateId
    
    # 'code, message = res.status'でstatusCodeを確認してから処理すること
    open(url)
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
  
  # Itemsの中身を取得(↓データ構造)
  # "Items": [
  #   {
  #     "Item": {
  #       "title": "Harry Potter",
  #       "other": "other data"
  #     }
  #   },
  #   {
  #     "Item": {
  #       ...
  #     }
  #   }
  # ]
  def getItems(json)
    json["Items"]
  end
  
  # 1件の情報を取得
  def getItemInfo(json)
    json["Item"]
  end
end