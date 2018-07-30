namespace :prices_scraper do
  desc 'Scrape the stock prices'
  task schedule_scrapes: :environment do
    Stock.where('created_at > ?', Time.now - 30.days).where('last_crawled IS NULL OR last_crawled < ?', Time.now - 10.days).each_with_index do |stock, index|
      ScrapeStockPriceWorker.perform_in((index + 0.5).minutes, stock['symbol'], 'intraday', stock.created_at)
      ScrapeStockPriceWorker.perform_in((index + 1).minutes, stock['symbol'], 'daily', stock.created_at)
    end
  end
end
