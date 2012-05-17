class UpdateHotels < ActiveRecord::Migration
  def change
    change_table :hotels do |t|
      t.rename :slug_ru, :slug
      t.remove :slug_en
    end
    add_index :hotels, :slug, unique: true
  end
end