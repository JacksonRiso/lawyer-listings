class ChangeTypeOnPrice < ActiveRecord::Migration
  def change
    rename_column :prices, :type, :price_type
  end
end
