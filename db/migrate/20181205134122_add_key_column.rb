class AddKeyColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :genres, :genre_groups_id, :integer
  end
end
