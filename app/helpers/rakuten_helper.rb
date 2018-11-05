module RakutenHelper
  # 楽天APIから得た情報が1件ならそれをJSONで取得
  def getItemInfo(json)
      # レスポンスに'count'があるので、それが1なら成功
      if json['count'] == 1
          return json['Items'][0]["Item"]
      else
          return nil
      end
  end
end