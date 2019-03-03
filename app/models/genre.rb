class Genre < ApplicationRecord
  belongs_to :genre_group
  validates :books_genre_id, presence: true
end