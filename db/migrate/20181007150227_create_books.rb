class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.text :title
      t.text :title_kana
      t.text :japanese_title
      t.string :author
      t.string :author_kana
      t.string :publisher_name
      t.integer :isbn
      t.text :item_caption
      t.date :seles_date
      t.integer :item_price
      t.string :item_url
      t.string :affiliate_url
      t.string :small_image_url
      t.string :medium_image_url
      t.string :large_image_url
      t.string :availability
      t.integer :review_count
      t.string :review_average
      t.string :books_genre_id
      t.integer :vocabulary
      t.string :official_url
      t.integer :page
      t.text :tags
      t.text :other

      t.timestamps
    end
  end
end
