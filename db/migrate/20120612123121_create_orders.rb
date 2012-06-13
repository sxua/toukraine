class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.integer :relative_id
      t.string :relative_type

      t.timestamps
    end
    add_index :orders, :relative_id
  end
end
