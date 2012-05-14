class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title_ru
      t.string :title_en
      t.text :body_ru
      t.text :body_en
      t.string :slug_ru
      t.string :slug_en
      t.string :category, default: 'other', null: false
      t.references :created_by
      t.references :published_by
      t.datetime :published_at
      t.boolean :is_published
      t.boolean :delta, default: true, null: false

      t.timestamps
    end
    add_index :pages, :created_by_id
    add_index :pages, :published_by_id
  end
end
