class CreateExtensionHstore < ActiveRecord::Migration
  def up
    execute("CREATE EXTENSION hstore") unless Rails.env.production?
  end

  def down
    execute("DROP EXTENSION hstore") unless Rails.env.production?
  end
end
