class CreateTours < ActiveRecord::Migration
  def change
    create_table :tours do |t|
      t.string :title_ru
      t.string :title_en
      t.text :description_ru
      t.text :description_en
      t.string :slug_ru
      t.string :slug_en
      t.boolean :delta, default: true, null: false
      t.timestamps
    end
  end
end
