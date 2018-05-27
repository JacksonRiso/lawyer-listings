namespace :avvo_scraper do
  desc 'Pick the top 3 unscraped URLs and scrape them'
  task schedule_scrapes: :environment do
    Url.where(last_crawled: nil, domain: "avvo").limit(10).each do |url|
      case url.url_type
      when 'location_list'
        ScrapeAvvoLocationListWorker.perform_async(url.url)
      when 'location'
        ScrapeAvvoLocationSpecialtyListWorker.perform_async(url.url)
      when 'location_specialty'
        ScrapeAvvoUsersListWorker.perform_async(url.url)
      when 'user'
        ScrapeAvvoUserPageWorker.perform_async(url.url)
      else
        puts "This is a failure!"
      end
    end
  end
end
