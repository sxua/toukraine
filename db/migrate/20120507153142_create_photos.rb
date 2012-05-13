class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :relative
      t.string :relative_type
      t.string :title_ru
      t.string :title_en
      t.string :image
      t.timestamps
    end
    add_index :photos, :relative_id
  end
end
