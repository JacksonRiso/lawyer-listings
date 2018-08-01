namespace :delete_duplicate_prices do
  desc 'Delete duplicate prices'
  task run: :environment do
    DeleteDuplicatePricesWorker.perform_async
  end
end
