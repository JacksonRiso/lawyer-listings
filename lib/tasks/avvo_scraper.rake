namespace :avvo_scraper do
  desc 'Pick the top 10 unscraped URLs and scrape them'
  task schedule_scrapes: :environment do
    Url.where(last_crawled: nil, domain: "avvo").limit(5).each do |url, index|
      url.update(last_crawled: Time.at(628232400))
      time = (index + 1).minutes
      case url.url_type
      when 'location_list'
        ScrapeAvvoLocationListWorker.perform_in(time, url.url)
      when 'location'
        ScrapeAvvoLocationSpecialtyListWorker.perform_in(time, url.url)
      when 'location_specialty'
        ScrapeAvvoUsersListWorker.perform_in(time, url.url)
      when 'user'
        ScrapeAvvoUserPageWorker.perform_in(time, url.url)
      else
        puts "This is a failure!"
        puts url.url_type
        puts "This is a failure!"
      end
    end
  end
end
