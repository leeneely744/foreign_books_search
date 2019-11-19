class Genre < ApplicationRecord
  belongs_to :genre_group
  has_many :books, primary_key: "books_genre_id", foreign_key: "books_genre_id", dependent: :destroy
  validates :books_genre_id, presence: true
end