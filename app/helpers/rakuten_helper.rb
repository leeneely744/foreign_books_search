module RakutenHelper
  # 楽天APIからのレスポンスに何件の書籍情報があるか
  def countItems(json)
    json['count']
  end
  
  # 1件の書籍情報を取得
  def getItemInfo(json)
    return json['Items'][0]["Item"]
  end
end