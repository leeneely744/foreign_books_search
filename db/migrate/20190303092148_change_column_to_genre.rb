class ChangeColumnToGenre < ActiveRecord::Migration[5.2]
  def up
    change_column :genres, :books_genre_id, :string, null: false
    change_column :genres, :books_genre_name, :string, null: false
  end

  def down
    change_column :genres, :books_genre_id, :string, null: true
    change_column :genres, :books_genre_name, :string, null: true
  end
end
