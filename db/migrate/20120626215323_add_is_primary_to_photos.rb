class AddIsPrimaryToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :is_primary, :boolean
  end
end
