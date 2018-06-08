# ScrapeAvvoUsersListWorker.perform_async("https://avvo.com/wrongful-termination-lawyer/al.html")

require 'rubygems'
require 'nokogiri'
require 'open-uri'

class ScrapeAvvoUsersListWorker
  include Sidekiq::Worker

  def perform(url)
    page = Nokogiri::HTML(open(url, 'User-Agent' => 'firefox'))

    # #Scrape pagination
    page.css('.serp-pagination').css('a').each do |specialty|
      link = 'https://avvo.com' + specialty['href']
      unless Url.find_by(url: link)
        Url.create(url: link, url_type: 'location_specialty', domain: 'avvo')
      end
    end

    # #Scrape users
    page.css('.lawyer-search-results').css('.v-serp-block-link').each do |lawyer|
      link = 'https://avvo.com' + lawyer['href']
      unless Url.find_by(url: link)
        Url.create(url: link, url_type: 'user', domain: 'avvo')
      end
    end

    # #Update the current url
    Url.find_by(url: url).update(last_crawled: Time.now)
  end
end
