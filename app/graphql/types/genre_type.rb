module Types
  class GenreType < Types::BaseObject
    field :id, ID, null: false
    field :books_genre_name, String, null: true
    field :books_genre_id, String, null: true
    field :genre_level, Integer, null: false
    field :genre_group_id, Integer, null: false
  end
end