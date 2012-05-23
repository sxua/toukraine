class AddWeightToPages < ActiveRecord::Migration
  def change
    add_column :pages, :weight, :integer, null: false, default: 10
  end
end
