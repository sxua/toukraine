class AddSomeStuffToTours < ActiveRecord::Migration
  def change
    add_column :tours, :prices_ru, :text
    add_column :tours, :prices_en, :text
    add_column :tours, :subtitle_ru, :string
    add_column :tours, :subtitle_en, :string
  end
end
