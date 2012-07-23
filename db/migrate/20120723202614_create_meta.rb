class CreateMeta < ActiveRecord::Migration
  def change
    create_table :meta do |t|
      t.references :relative
      t.string :relative_type
      t.string :keywords_ru
      t.string :description_ru
      t.string :keywords_ua
      t.string :description_ua
      t.string :keywords_en
      t.string :description_en

      t.timestamps
    end
    add_index :meta, :relative_id
  end
end
