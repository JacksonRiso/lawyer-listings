#ScrapeAvvoLocationListWorker.perform_async("https://www.avvo.com/bankruptcy-debt-lawyer/al.html")

require 'rubygems'
require 'nokogiri'
require 'open-uri'

class ScrapeAvvoUsersListWorker
  include Sidekiq::Worker

  def perform(url)

    url = "https://www.avvo.com/bankruptcy-debt-lawyer/al.html"
    page = Nokogiri::HTML(open(url, 'User-Agent' => 'firefox'))

    ##Scrape pagination
    page.css('.serp-pagination').css("a").each do |specialty|
      link = "https://avvo.com" + specialty["href"]
      unless URL.find_by(url: link)
        Url.create(url: link, url_type: "location_specialty", domain: "Avvo")
      end
    end

    ##Scrape users
    page.css('.lawyer-search-results').css(".v-serp-block-link").each do |lawyer|
      link = "https://avvo.com" + lawyer["href"]
      unless URL.find_by(url: link)
        Url.create(url: link, url_type: "lawyer", domain: "Avvo")
      end
    end

    ##Update the current url
    Url.find_by(url: url).update(last_crawled: Time.now())

  end
end
