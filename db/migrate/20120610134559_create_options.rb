class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :title
      t.string :key
      t.string :value
    end
    add_index :options, :key
  end
end
