class RenameBookIdColumnToFavorites < ActiveRecord::Migration[5.2]
  def change
  	rename_column :favorites, :book__id, :book_id
  end
end
