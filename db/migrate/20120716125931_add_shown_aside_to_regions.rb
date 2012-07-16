class AddShownAsideToRegions < ActiveRecord::Migration
  def change
    add_column :regions, :shown_aside, :boolean
  end
end
