class UpdateTours < ActiveRecord::Migration
  def change
    change_table :tours do |t|
      t.rename :slug_ru, :slug
      t.remove :slug_en
    end
    add_index :tours, :slug, unique: true
  end
end
