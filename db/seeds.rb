require "csv"

# バルクインサートはPostgres9.5+ でしか使えないので、そのうちバージョンアップする
# 最初の一行はヘッダー行
CSV.foreach('db/csv/bookData.csv', headers: true) do |data|
    puts "作業中: #{data["isbn"]}"
   Book.create!(
        :isbn => data["isbn"],
        :vocabulary => data["vocabulary"],
        :page => data["page"],
        :official_url => data["official_url"]
        )
end