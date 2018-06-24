class AddLastCrawledToSTocks < ActiveRecord::Migration
  def change
    add_column :stocks, :last_crawled, :datetime
  end
end
