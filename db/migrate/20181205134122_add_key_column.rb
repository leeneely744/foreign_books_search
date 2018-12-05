class AddKeyColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :genres, :genre_group_id, :integer
  end
end
