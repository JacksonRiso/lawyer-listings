namespace :delete_duplicate_prices do
  desc 'Delete duplicate prices'
  task run: :environment do
    Price.where(days_since_crawl: nil).limit(10_000).each do |price|
      # Look up created_at based on symbol
      stock_created_at = Stock.find_by(symbol: price.symbol).created_at
      days_since_crawl = (stock_created_at.to_date - price.datetime.to_date).to_i
      Price.find_by(id: price.id).update(days_since_crawl: days_since_crawl)

      # Delete duplicates
      prices = Price.where(symbol: price.symbol, price_type: price.price_type, datetime: price.datetime)
      prices.first.destroy if prices.count > 1
    end
  end
end
