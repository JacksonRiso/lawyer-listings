namespace :prices_scraper do
  desc 'Scrape the stock prices'
  task schedule_scrapes: :environment do
    Stock.where('created_at < ?', Time.now - 29.days).where('last_crawled IS NULL').each_with_index do |stock, index|
      # ScrapeStockPriceWorker.perform_in((index + 0.5).minutes, stock['symbol'], 'intraday', stock.created_at)
      ScrapeStockPriceWorker.perform_in((index + 1).minutes, stock['symbol'], stock.created_at)
    end
  end
end
