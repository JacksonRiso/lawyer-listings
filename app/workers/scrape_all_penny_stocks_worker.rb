# ScrapeAllPennyStocksWorker.perform_async()

require 'rubygems'
require 'nokogiri'
require 'open-uri'

class ScrapeAllPennyStocksWorker
  include Sidekiq::Worker

  def perform
    urls = ['http://www.allpennystocks.com/aps_us/hot_nasdaq_stocks.asp', 'http://www.allpennystocks.com/aps_us/hot_otc_stocks.asp']
    urls.each do |url|
      page = Nokogiri::HTML(open(url, 'User-Agent' => 'firefox'))
      page.css('#dataTable').css('tr').each do |table_row|
        next unless table_row.css('td')[0]
        symbol = table_row.css('td')[0].text
        unless Stock.find_by(symbol: symbol)
          Stock.create(symbol: symbol, source: url)
        end
      end
    end
  end
end
