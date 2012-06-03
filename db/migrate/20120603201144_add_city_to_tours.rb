class AddCityToTours < ActiveRecord::Migration
  def change
    add_column :tours, :city_id, :integer
    add_index :tours, :city_id
  end
end
