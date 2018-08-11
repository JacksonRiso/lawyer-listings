class RemovePriceType < ActiveRecord::Migration[5.0]
  def change
    remove_column :prices, :price_type
  end
end
