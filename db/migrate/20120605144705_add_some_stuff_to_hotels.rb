class AddSomeStuffToHotels < ActiveRecord::Migration
  def change
    add_column :hotels, :price, :integer
    add_column :hotels, :currency, :integer
  end
end
