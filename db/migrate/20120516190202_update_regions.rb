class UpdateRegions < ActiveRecord::Migration
  def change
    change_table :regions do |t|
      t.rename :slug_ru, :slug
      t.remove :slug_en
    end
    add_index :regions, :slug, unique: true
  end
end
