namespace :delete_duplicate_prices do
  desc 'Delete duplicate prices'
  task run: :environment do
    Price.find_each do |price|
      prices = Price.where(symbol: price.symbol, price_type: price.price_type, datetime: price.datetime)
      prices.first.destroy if prices.count > 1
    end
  end
end
