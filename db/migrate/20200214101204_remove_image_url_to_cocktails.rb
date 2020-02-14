class RemoveImageUrlToCocktails < ActiveRecord::Migration[5.2]
  def change
    remove_column :cocktails, :image_url
  end
end
