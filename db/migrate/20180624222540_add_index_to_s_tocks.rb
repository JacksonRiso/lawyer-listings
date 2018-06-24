class AddIndexToSTocks < ActiveRecord::Migration[5.0]
  def change
    add_index :stocks, :symbol
    add_index :urls, :url
    add_column :prices, :unique_identifier, :string
    add_index :prices, :unique_identifier
  end
end
