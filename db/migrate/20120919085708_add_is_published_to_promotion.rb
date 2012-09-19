class AddIsPublishedToPromotion < ActiveRecord::Migration
  def change
    add_column :promotions, :is_published, :boolean
  end
end
