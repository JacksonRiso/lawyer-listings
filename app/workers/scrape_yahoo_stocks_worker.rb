# ScrapeYahooStocksWorker.perform_async()

require 'rubygems'
require 'nokogiri'
require 'open-uri'

class ScrapeYahooStocksWorker
  include Sidekiq::Worker

  def perform
    urls = ['https://finance.yahoo.com/gainers', 'https://finance.yahoo.com/losers']
    urls.each do |url|
      page = Nokogiri::HTML(open(url, 'User-Agent' => 'firefox'))
      page.css('#scr-res-table').css('tr').each do |table_row|
        next unless table_row.css('td')[1]
        symbol = table_row.css('td')[1].text
        unless Stock.find_by(symbol: symbol)
          Stock.create(symbol: symbol, source: url)
        end
      end
    end
    # #END
  end
end
