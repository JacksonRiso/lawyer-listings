namespace :prices_scraper do
  desc 'Scrape the stock prices'
  task schedule_scrapes: :environment do
    Stock.where('created_at > ?', Time.now - 30.days).each_with_index do |stock, index|
      ScrapeStockPriceWorker.perform_in((index + 0.5).minutes, stock['symbol'], 'intraday')
      ScrapeStockPriceWorker.perform_async((index + 1).minutes, stock['symbol'], 'daily')
    end
  end
end
