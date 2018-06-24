namespace :avvo_scraper do
  desc 'Pick the top 10 unscraped URLs and scrape them'
  task schedule_scrapes: :environment do
    unless REDIS.get('avvo_scraper_last_error') > Time.now - 1.hour
      Url.where(last_crawled: nil, domain: 'avvo').limit(5).each_with_index do |url, index|
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
          raise 'Url type does not match options in avvo_scraper.rake'
        end
      end
    end
  end
end
