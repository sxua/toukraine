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
      t.timestamps
    end
    add_index :hotels, :city_id
  end
end
