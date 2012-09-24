class AddPreviewToNews < ActiveRecord::Migration
  def change
    add_column :news, :preview_ru, :text
    add_column :news, :preview_ua, :text
    add_column :news, :preview_en, :text
  end
end
