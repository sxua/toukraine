class CreateAttributes < ActiveRecord::Migration
  def up
    create_table :attributes do |t|
      t.references :relative
      t.string :relative_type
      t.hstore :data_ru
      t.hstore :data_en
    end
    add_index :attributes, :relative_id
    execute("CREATE INDEX attributes_gist_data_ru ON attributes USING GIST(data_ru)")
    execute("CREATE INDEX attributes_gist_data_en ON attributes USING GIST(data_en)")
  end

  def down
    execute("DROP INDEX attributes_gist_data_ru")
    execute("DROP INDEX attributes_gist_data_en")
    remove_index :attributes, :relative_id
    drop_table :attributes
  end
end
