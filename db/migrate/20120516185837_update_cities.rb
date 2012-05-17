class UpdateCities < ActiveRecord::Migration
  def change
    change_table :cities do |t|
      t.rename :slug_ru, :slug
      t.remove :slug_en
    end
    add_index :cities, :slug, unique: true
  end
end
