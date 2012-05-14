class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :title_ru
      t.string :title_en
      t.references :parent
      t.integer :lft
      t.integer :rgt
      t.string :slug_ru
      t.string :slug_en
      t.timestamps
    end
    add_index :regions, :parent_id
  end
end
