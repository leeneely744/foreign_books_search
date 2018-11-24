class RemoveJanFromBooks < ActiveRecord::Migration[5.2]
  def change
    remove_column :books, :jan, :string
  end
end
