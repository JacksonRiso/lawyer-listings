namespace :lawyer_website_scraper do
  desc 'Pick the top 10 unscraped URLs and scrape them'
  task schedule_scrapes: :environment do
    Lawyer.where(website_crawled: nil, website_status_code: nil).where('website IS NOT NULL').limit(10).each_with_index do |lawyer, index|
      time = (index + 1).minutes
      ScrapeLawyerWebsiteWorker.perform_in(time, lawyer.website.to_s, lawyer.id)
    end
  end
end
