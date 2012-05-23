class CreateTourTypes < ActiveRecord::Migration
  def change
    create_table :tour_types do |t|
      t.string :title_ru
      t.string :title_en

      t.timestamps
    end
  end
end
