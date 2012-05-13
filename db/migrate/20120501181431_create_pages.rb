class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title_ru
      t.string :title_en
      t.string :body_ru
      t.string :body_en
      t.references :created_by
      t.references :published_by
      t.datetime :published_at
      t.boolean :is_published

      t.timestamps
    end
    add_index :pages, :created_by_id
    add_index :pages, :published_by_id
  end
end
