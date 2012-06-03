class ChangeTourType < ActiveRecord::Migration
  def up
    remove_column :tours, :tour_type_id
    add_column :tours, :tour_type_id, :integer
    add_column :tours, :visible_ru, :boolean
    add_column :tours, :visible_en, :boolean
    add_column :tour_types, :slug, :string
  end

  def down
    remove_column :tours, :tour_type_id
    add_column :tours, :tour_type_id, :boolean
    remove_column :tours, :visible_ru
    remove_column :tours, :visible_en
    remove_column :tour_types, :slug
  end
end
