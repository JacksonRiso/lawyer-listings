class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
    	t.string :url
    	t.string :url_type
    	t.string :domain
    	t.datetime :last_crawled
      t.timestamps null: false
    end
  end
end
