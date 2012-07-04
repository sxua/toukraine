class UpdateOrdersWithNewFields < ActiveRecord::Migration
  def change
    add_column :orders, :come_in_date, :datetime
    add_column :orders, :come_out_date, :datetime
    add_column :orders, :people_amount, :datetime
    add_column :orders, :description, :text
  end
end
