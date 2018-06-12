class AddBooleanToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :alpha_vantage, :boolean
  end
end
