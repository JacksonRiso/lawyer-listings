# ScrapeStockPrice.perform_async("MSFT", "intraday")
# ScrapeStockPrice.perform_async("MSFT", "daily")

require 'rubygems'
require 'nokogiri'
require 'open-uri'

class ScrapeStockPriceWorker
  include Sidekiq::Worker

  def perform(symbol, type)
    api_key = '3TQBEBDIPSL35F38'
    outputsize = 'full'
    intraday_interval = '30min'
    base_url = ''

    if type == 'intraday'
      url = ''
    elsif type == 'daily'
      url = ''
    end
    puts symbol
    puts type
  end
end
