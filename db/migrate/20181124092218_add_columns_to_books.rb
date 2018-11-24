class AddColumnsToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :title_kana, :text
    add_column :books, :japanes_title, :text
    add_column :books, :author_kana, :string
  end
end
