class AddDifferencesToPrices < ActiveRecord::Migration[5.0]
  def change
    add_column :prices, :percent_difference_between_open_and_close, :decimal
    add_column :prices, :percent_difference_between_low_and_high, :decimal
  end
end
