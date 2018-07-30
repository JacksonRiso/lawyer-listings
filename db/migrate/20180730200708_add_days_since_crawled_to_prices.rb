class AddDaysSinceCrawledToPrices < ActiveRecord::Migration[5.0]
  def change
    add_column :prices, :days_since_crawl, :integer
  end
end
