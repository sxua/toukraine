class AddUaToEverything < ActiveRecord::Migration
  def change
    add_column :cities, :title_ua, :string
    add_column :hotels, :title_ua, :string
    add_column :hotels, :description_ua, :text
    add_column :hotels, :address_ua, :string
    add_column :hotels, :prices_ua, :text
    add_column :hotels, :short_description_ua, :text
    add_column :news, :title_ua, :string
    add_column :news, :body_ua, :text
    add_column :pages, :title_ua, :string
    add_column :pages, :body_ua, :text
    add_column :pages, :visible_ua, :boolean
    add_column :photos, :title_ua, :string
    add_column :promotions, :title_ua, :string
    add_column :promotions, :caption_ua, :string
    add_column :regions, :title_ua, :string
    add_column :sights, :title_ua, :string
    add_column :sights, :description_ua, :text
    add_column :tour_types, :title_ua, :string
    add_column :tours, :title_ua, :string
    add_column :tours, :description_ua, :text
    add_column :tours, :visible_ua, :boolean
    add_column :tours, :prices_ua, :text
    add_column :tours, :subtitle_ua, :string
  end
end
