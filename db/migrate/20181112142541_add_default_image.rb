class AddDefaultImage < ActiveRecord::Migration[5.2]
  def change
    change_column_default("books", "small_image_url",  "no_image_small.png")
    change_column_default("books", "medium_image_url", "no_image_medium.png")
    change_column_default("books", "large_image_url",  "no_image_large.png")
  end
end
