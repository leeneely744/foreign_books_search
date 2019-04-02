class Book < ApplicationRecord
  validates :isbn, presence: true

  # 書籍を更新する。
  # updateに成功したらtrueを返す。
  # updateで例外が発生したら、Exceptionインスタンスを返す
  def updateBookAttributes(attributesHash)
    # ※ 楽天から返ってくるキーはキャメルケースになっている
    updates = {}
    attributesHash.each do |key, val|
      if Book.has_attribute?(key.underscore)
        updates[key.underscore] = val
      end
    end.to_h

    # '.save' saves the record only if changes were made.
    updates[:updated_at] = Time.now

    begin
      self.update!(updates)
      return true
    rescue => exception
      return exception
    end
  end
end
