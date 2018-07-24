class AddCrawledToLawyers < ActiveRecord::Migration[5.0]
  def change
    add_column :lawyers, :website_crawled, :datetime
  end
end
