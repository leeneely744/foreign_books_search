module Types
  class GenreGroupType < Types::BaseObject
    field :id, ID, null: false
    field :books_genre_id, String, null: false
    field :books_genre_name, String, null: false
    field :genre_level, Integer, null: false
    field :genres, [GenreType], '子ジャンル', null: false
  end
end