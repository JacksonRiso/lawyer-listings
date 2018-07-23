namespace :lawyer_website_scraper do
  desc 'Pick the top 10 unscraped URLs and scrape them'
  task schedule_scrapes: :environment do
    Lawyer.where(website_crawled: nil).limit(10).each_with_index do |lawyer, index|
      time = (index + 1).minutes
      ScrapeLawyerWebsiteWorker.perform_in(time, lawyer.website, lawyer.id)
    end
  end
end
