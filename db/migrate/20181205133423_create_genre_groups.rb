class CreateGenreGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :genre_groups do |t|
      t.string :books_genre_id
      t.string :books_genre_name
      t.integer :genre_level

      t.timestamps
    end
  end
end
