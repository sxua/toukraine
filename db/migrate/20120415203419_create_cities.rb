class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :title_ru
      t.string :title_en
    end
  end
end
