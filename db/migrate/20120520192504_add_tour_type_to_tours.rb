class AddTourTypeToTours < ActiveRecord::Migration
  def change
    add_column :tours, :tour_type_id, :boolean
    add_index :tours, :tour_type_id
  end
end
