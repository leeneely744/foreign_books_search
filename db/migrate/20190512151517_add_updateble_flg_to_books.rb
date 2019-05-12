class AddUpdatebleFlgToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :updatable_flg, :boolean, default: true, null: false
  end
end
