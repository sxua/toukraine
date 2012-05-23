class CreateIntableHstore < ActiveRecord::Migration
  def up
    drop_table :attributes
    execute("ALTER TABLE hotels ADD data hstore default hstore(array[]::varchar[])")
    execute("ALTER TABLE tours ADD data hstore default hstore(array[]::varchar[])")
    execute("CREATE INDEX hotels_gist_data ON hotels USING GIST(data)")
    execute("CREATE INDEX tours_gist_data ON tours USING GIST(data)")
  end
  
  def down
    execute("DROP INDEX hotels_gist_data_ru")
    execute("DROP INDEX hotels_gist_data_en")
    execute("DROP INDEX tours_gist_data_ru")
    execute("DROP INDEX tours_gist_data_en")
    remove_column :hotels, :data
    remove_column :tours, :data
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
end
