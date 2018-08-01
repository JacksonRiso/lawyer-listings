namespace :add_differences_to_prices do
  desc 'Grab stock prices and add the difference values'
  task run: :environment do
    AddDifferencesToPricesWorker.perform_async
  end
end
