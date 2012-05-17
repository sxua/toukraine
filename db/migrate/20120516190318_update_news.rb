class UpdateNews < ActiveRecord::Migration
  def change
    change_table :news do |t|
      t.rename :slug_ru, :slug
      t.remove :slug_en
    end
    add_index :news, :slug, unique: true
  end
end
