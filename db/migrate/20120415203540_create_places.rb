class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.references :city
      t.string :title_ru
      t.string :title_en
      t.text :description_ru
      t.text :description_en
      t.string :address_ru
      t.string :address_en
      t.string :slug_ru
      t.string :slug_en
      t.references :place_type
      t.boolean :delta, default: true, null: false
      t.timestamps
    end
    add_index :places, :city_id
    add_index :places, :place_type_id
  end
end
