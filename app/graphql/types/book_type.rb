module Types
  class BookType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :books_genre_id, String, null: false
    field :small_image_url, String, null: false
    field :medium_image_url, String, null: false
    field :large_image_url, String, null: false
    field :review_count, Integer, null: false
    field :review_aveerage, String, null: false
    field :vocabulary, Integer, null: false
    field :page, Integer, null: false
  end
end