# ScrapeAllPennyStocksWorker.perform_async()

require 'rubygems'
require 'nokogiri'
require 'open-uri'

class ScrapeAllPennyStocksWorker
  include Sidekiq::Worker
  sidekiq_options queue: :stock, retry: false, backtrace: true

  def perform
    urls = ['http://www.allpennystocks.com/aps_us/hot_nasdaq_stocks.asp', 'http://www.allpennystocks.com/aps_us/hot_otc_stocks.asp']
    urls.each do |url|
      page = Nokogiri::HTML(open(url, 'User-Agent' => 'firefox'))
      page.css('#dataTable').css('tr').each do |table_row|
        next unless table_row.css('td')[0]
        symbol = table_row.css('td')[0].text
        amount_change = table_row.css('td')[7].css('span')[0].text
        percent_change = table_row.css('td')[7].css('span')[1] ? table_row.css('td')[7].css('span')[1].text : nil
        puts amount_change
        puts percent_change
        # unless Stock.find_by(symbol: symbol)
        #   Stock.create(symbol: symbol, source: url, amount_change: amount_change.to_d, percent_change: percent_change.to_d)
        # end
      end
    end
  end
end
