class UpdateHotelsForTemplate < ActiveRecord::Migration
  def change
    change_table :hotels do |t|
      t.text :prices_ru
      t.text :prices_en
      t.point :latlon, geographic: true, srid: 4326
      t.remove_references :hotel_type
      t.index :latlon, spatial: true
    end
  end
end
