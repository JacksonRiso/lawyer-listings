namespace :avvo_scraper do
  desc 'Scrape the highest performing stocks of the day'
  task schedule_scrapes: :environment do
    ScrapeYahooStocksWorker.perform_async
    ScrapeAllPennyStocksWorker.perform_async
  end
end
