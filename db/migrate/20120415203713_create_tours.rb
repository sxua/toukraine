class CreateTours < ActiveRecord::Migration
  def change
    create_table :tours do |t|
      t.string :title_ru
      t.string :title_en
      t.text :description_ru
      t.text :description_en
      t.timestamps
    end
  end
end
