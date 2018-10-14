require "csv"

books = []

# バルクインサートの使い方
# https://qiita.com/xend/items/79184ded56158ea1b97a#rails%E3%81%A7bulk-insert%E3%82%92%E4%BD%BF%E3%81%86
CSV.foreach('db/csv/books.csv') do |book|
    books << Book.new()
end

# すでにレコードが存在する場合は、isbn以外のカラムだけ更新
# https://paranishian.hateblo.jp/entry/2015/11/06/142412
Book.import books, on_duplicate_key_update: [
    :title,
    :author,
    :publisher_name,
    :isbn,
    :jan,
    :item_caption,
    :seles_date,
    :item_url,
    :affiliate_url,
    :small_image_url,
    :medium_image_url,
    :large_image_url,
    :review_count,
    :review_average,
    :books_genre_id,
    :vocabulary,
    :official_url,
    :page,
    :tags,
    :other
    ]