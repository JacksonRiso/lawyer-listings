# ScrapeStockPriceWorker.perform_async("MSFT", "intraday")
# ScrapeStockPriceWorker.perform_async("MSFT", "daily")

# Stock.where(alpha_vantage: false).each do |stock|
#   stock.update(alpha_vantage: nil)
# end
# Stock.where('length(symbol) > 5').count

require 'rubygems'
require 'nokogiri'
require 'open-uri'

class ScrapeStockPriceWorker
  include Sidekiq::Worker
  sidekiq_options queue: :price, retry: false, backtrace: false

  def perform(symbol, stock_created_at)
    url = 'https://www.alphavantage.co/query?symbol=' + symbol + '&function=TIME_SERIES_DAILY&outputsize=full&apikey=3TQBEBDIPSL35F38'

    HTTParty.get(url).values[1].each do |key, array|
      # Get all the values
      datetime = key
      open = array['1. open']
      close = array['4. close']
      high = array['2. high']
      low = array['3. low']
      volume = array['5. volume']
      days_since_crawl = (stock_created_at.to_date - datetime.to_date).to_i

      # Check if the datetime and symbol already exists
      unless Price.find_by(symbol: symbol, datetime: datetime)
        Price.create(symbol: symbol, datetime: datetime, open: open, close: close, high: high, low: low, volume: volume, days_since_crawl: days_since_crawl)
      end
      # Update the Stock
      Stock.find_by(symbol: symbol).update(alpha_vantage: true, last_crawled: Time.now)
    end
  end
end
