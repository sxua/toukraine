class CreateBackgrounds < ActiveRecord::Migration
  def change
    create_table :backgrounds do |t|
      t.string :image
      t.integer :position

      t.timestamps
    end
  end
end
