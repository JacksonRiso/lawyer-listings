# ScrapeYahooStocksWorker.perform_async()

require 'rubygems'
require 'nokogiri'
require 'open-uri'

class ScrapeYahooStocksWorker
  include Sidekiq::Worker
  sidekiq_options queue: :stock, retry: false, backtrace: true

  def perform
    urls = ['https://finance.yahoo.com/gainers', 'https://finance.yahoo.com/losers']
    urls.each do |url|
      page = Nokogiri::HTML(open(url, 'User-Agent' => 'firefox'))
      page.css('#scr-res-table').css('tr').each do |table_row|
        next unless table_row.css('td')[1]
        symbol = table_row.css('td')[1].text
        amount_change = table_row.css('td')[3].text
        percent_change = table_row.css('td')[4].text
        unless Stock.find_by(symbol: symbol)
          Stock.create(symbol: symbol, source: url, amount_change: amount_change.to_d, percent_change: percent_change.to_d)
        end
      end
    end
    # #END
  end
end
