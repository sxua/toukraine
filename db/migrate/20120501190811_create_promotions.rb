class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.string :title_ru
      t.string :title_en
      t.string :caption_ru
      t.string :caption_en
      t.string :image
      t.string :url
      t.references :tour
      t.references :place
      t.string :url_type
      t.timestamps
    end
    add_index :promotions, :tour_id
    add_index :promotions, :place_id
  end
end
