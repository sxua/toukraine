class UpdatePages < ActiveRecord::Migration
  def change
    change_table :pages do |t|
      t.rename :slug_ru, :slug
      t.remove :slug_en
      t.boolean :visible_ru, default: false, null: false
      t.boolean :visible_en, default: false, null: false
    end
    add_index :pages, :slug, unique: true
  end
end
