class CreateSights < ActiveRecord::Migration
  def change
    create_table :sights do |t|
      t.string :title_ru
      t.string :title_en
      t.text :description_ru
      t.text :description_en
      t.references :city
      t.string :slug
      t.boolean :delta

      t.timestamps
    end
    add_index :sights, :city_id
  end
end
