class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.references :city
      t.string :title_ru
      t.string :title_en
      t.text :description_ru
      t.text :description_en
      t.string :address_ru
      t.string :address_en
      t.string :slug_ru
      t.string :slug_en
      t.references :hotel_type
      t.boolean :delta, default: true, null: false
      t.timestamps
    end
    add_index :hotels, :city_id
    add_index :hotels, :hotel_type_id
  end
end
