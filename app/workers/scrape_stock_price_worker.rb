# ScrapeStockPriceWorker.perform_async("MSFT", "intraday")
# ScrapeStockPriceWorker.perform_async("MSFT", "daily")

require 'rubygems'
require 'nokogiri'
require 'open-uri'

class ScrapeStockPriceWorker
  include Sidekiq::Worker

  def perform(symbol, type)
    # symbol = 'MSFT'
    # type = 'daily'
    apikey = '3TQBEBDIPSL35F38'
    base_url = 'https://www.alphavantage.co/query'

    if type == 'intraday'
      url = base_url + '?symbol=' + symbol + '&function=TIME_SERIES_INTRADAY&interval=30min&outputsize=full&apikey=' + apikey
    elsif type == 'daily'
      url = base_url + '?symbol=' + symbol + '&function=TIME_SERIES_DAILY&outputsize=full&apikey=' + apikey
    end

    HTTParty.get(url).values[1].each do |key, array|
      # Get all the values
      datetime = key
      open = array['1. open']
      close = array['4. close']
      high = array['2. high']
      low = array['3. low']
      volume = array['5. volume']

      # Check if the datetime and symbol already exists
      unless Price.find_by(symbol: symbol, type: type, datetime: datetime)
        Price.create(symbol: symbol, type: type, datetime: datetime, open: open, close: close, high: high, low: low, volume: volume)
      end
    end
  end
end
