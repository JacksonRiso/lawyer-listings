class RemoveUniqueIdentifierColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :prices, :unique_identifier
  end
end
