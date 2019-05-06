=begin
データを更新しなければならない頻度
https://webservice.faq.rakuten.co.jp/app/answers/detail/a_id/15555/related/1

(1)データのキャッシュに関して
デベロッパーは、一般的に以下の期間であれば、
データをキャッシュする目的で楽天グループ（以下、「当社」とする。）の
知的財産を格納することができます。
・商品の価格情報、および販売可能情報：24時間
・その他の情報：3か月間

※下記(3)の当社の権利に限定されることなく、
当社はいつでも上記の当社の知的財産を削除するよう
デベロッパーに指示することができ、デベロッパーは、
かかる指示をただちに遵守することに了承し、合意します。

(2)表示されるデータの更新頻度に関して
デベロッパーは、アプリケーション上またはアプリケーション内に
価格情報または販売可能情報を表示する場合、
情報を少なくとも1週間に1回、各APIから新たに取得した情報に刷新し、
再表示しなければなりません。

(3) データ取得日時の表示に関して
デベロッパーは、１時間に１回以上データを更新しない場合は、
価格情報または在庫情報等の情報に隣接した位置に
更新時刻・日時を記載しなければなりません。
その際、下記の免責事項を、価格情報または販売可能情報等の情報に
隣接して掲載するか、ハイパーリンク等の方法で掲載しなければなりません。

「このサイトで掲載されている情報は、●●（サイト名）の作成者により
運営されています。価格、販売可能情報は、変更される場合があります。
購入時に楽天市場店舗（www.rakuten.co.jp）に表示されている価格が、
その商品の販売に適用されます。」 
=end

require 'date'

include RakutenHelper
include BooksHelper

=begin
楽天ブックス総合検索APIから最新の書籍情報を取得する。
1度の起動で100件の書籍情報の更新を行う。
まとめて取得するAPIは存在しないので、1件ずつ情報を更新する。
楽天APIの負荷を考慮して、2秒に1件のペースで問い合わせを行う。
=end

logPath = Rails.root."/log/batchUpdateBook.log"
myLogger = Logger.new(logPath)

updateLimit = 3.months.ago
getNumOnce = 100
books = Book
.where("created_at = ? or updated_at < ?", nil, updateLimit)
.order('updated_at DESC')
.limit(getNumOnce)

loopCount = 1
books.each do |book|
  isbn = book.isbn
  puts "#{loopCount}: isbn = #{book.isbn} を更新します。"

  res = requestToRBOSApiByIsbn(isbn)
  resJson = JSON.parse(res.read)

  newAttributes = getOneBookAttributesFromResponse(resJson)
  result = Book.find_by(isbn: isbn).updateBookAttributes(newAttributes)

  if result == true
    puts "ISBN = #{isbn} の書籍情報の更新に成功しました。"
  else
    errMessage = "ISBN = #{isbn} の書籍情報の更新に失敗しました。\n"
    errMessage += result.message
    myLogger.error(errMessage)
  end

  # 楽天APIへの負荷を考えて2秒待つ
  sleep(2)
end