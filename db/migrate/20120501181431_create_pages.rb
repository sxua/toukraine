class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title_ru
      t.string :title_en
      t.string :body_ru
      t.string :body_en
      t.integer :created_by
      t.datetime :published_at
      t.boolean :is_published

      t.timestamps
    end
  end
end
