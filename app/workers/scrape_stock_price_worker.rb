# ScrapeStockPriceWorker.perform_async("MSFT", "intraday")
# ScrapeStockPriceWorker.perform_async("MSFT", "daily")

require 'rubygems'
require 'nokogiri'
require 'open-uri'

class ScrapeStockPriceWorker
  include Sidekiq::Worker
  sidekiq_options queue: :price, retry: false, backtrace: false

  def perform(symbol, price_type)
    # symbol = 'MSFT'
    # price_type = 'daily'
    apikey = '3TQBEBDIPSL35F38'
    base_url = 'https://www.alphavantage.co/query'

    if price_type == 'intraday'
      url = base_url + '?symbol=' + symbol + '&function=TIME_SERIES_INTRADAY&interval=30min&outputsize=full&apikey=' + apikey
    elsif price_type == 'daily'
      url = base_url + '?symbol=' + symbol + '&function=TIME_SERIES_DAILY&outputsize=full&apikey=' + apikey
    end

    begin
      HTTParty.get(url).values[1].each do |key, array|
        # Get all the values
        datetime = key
        open = array['1. open']
        close = array['4. close']
        high = array['2. high']
        low = array['3. low']
        volume = array['5. volume']

        # Check if the datetime and symbol already exists
        unique_identifier = symbol + '-' + price_type + '-' + datetime.to_s
        unless Price.find_by(unique_identifier: unique_identifier)
          Price.create(unique_identifier: unique_identifier, symbol: symbol, price_type: price_type, datetime: datetime, open: open, close: close, high: high, low: low, volume: volume)
        end
        # Update the Stock
        Stock.find_by(symbol: symbol).update(alpha_vantage: true, last_crawled: Time.now)
      end
    rescue StandardError
      puts 'There is no data for this stock in AlphaVantage'
      Stock.find_by(symbol: symbol).update(alpha_vantage: false)
      puts "Updated stock so it won't be crawled again"
    end
  end
end
