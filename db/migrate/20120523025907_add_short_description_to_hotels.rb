class AddShortDescriptionToHotels < ActiveRecord::Migration
  def change
    add_column :hotels, :short_description_ru, :text
    add_column :hotels, :short_description_en, :text
  end
end
