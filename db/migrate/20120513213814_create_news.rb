class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title_ru
      t.string :title_en
      t.text :body_ru
      t.text :body_en
      t.string :slug_ru
      t.string :slug_en
      t.references :created_by
      t.references :published_by
      t.datetime :published_at
      t.boolean :is_published
      t.boolean :delta, default: true, null: false

      t.timestamps
    end
    add_index :news, :created_by_id
    add_index :news, :published_by_id
  end
end
