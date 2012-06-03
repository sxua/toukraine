class AddPriceToTours < ActiveRecord::Migration
  def change
    add_column :tours, :price, :integer
    add_column :tours, :currency, :integer
  end
end
