class AddMenuToRegions < ActiveRecord::Migration
  def change
    add_column :regions, :menu, :boolean
  end
end
