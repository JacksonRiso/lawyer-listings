class AddVariousColumnsToPrices < ActiveRecord::Migration[5.0]
  def change
    add_column :stocks, :amount_change, :decimal
    add_column :stocks, :percent_change, :decimal
  end
end
