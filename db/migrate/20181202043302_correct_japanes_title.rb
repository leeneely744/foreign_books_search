class CorrectJapanesTitle < ActiveRecord::Migration[5.2]
  def change
    rename_column :books, :japanes_title, :japanese_title
  end
end
