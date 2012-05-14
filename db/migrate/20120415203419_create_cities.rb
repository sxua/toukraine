class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :title_ru
      t.string :title_en
      t.string :slug_ru
      t.string :slug_en
      t.references :region
      t.boolean :delta, default: true, null: false
    end
  end
end
