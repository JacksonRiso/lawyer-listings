class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.string :symbol
      t.string :type
      t.datetime :datetime
      t.decimal :open
      t.decimal :close
      t.decimal :high
      t.decimal :low
      t.integer :volume
      t.timestamps null: false
    end
  end
end
