class CreatePlaceTypes < ActiveRecord::Migration
  def change
    create_table :place_types do |t|
      t.string :title_ru
      t.string :title_en

      t.timestamps
    end
  end
end
