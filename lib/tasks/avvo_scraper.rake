namespace :avvo_scraper do
  desc 'Pick the top 10 unscraped URLs and scrape them'
  task schedule_scrapes: :environment do
    Url.where(last_crawled: nil, domain: "avvo").limit(5).each do |url|
      url.update(last_crawled: Time.at(628232400))
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
        puts url.url_type
        puts "This is a failure!"
      end
    end
  end
end
