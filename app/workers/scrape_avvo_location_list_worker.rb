#ScrapeAvvoLocationListWorker.perform_async("https://www.avvo.com/find-a-lawyer")

require 'rubygems'
require 'nokogiri'
require 'open-uri'

class ScrapeAvvoLocationListWorker
  include Sidekiq::Worker

  def perform(url)
    ## Grab the page
    url = "https://www.avvo.com/find-a-lawyer"
    page = Nokogiri::HTML(open(url, 'User-Agent' => 'firefox'))
    #Grab each list item and puts the link
    page.css('#js-top-state-link-farm').css("ol.unstyled-list").css("li").each do |state|
    	link = "https://avvo.com" + state.css("a")[0]["href"]
      Url.create(url: link, url_type: "location", last_crawled: )
    end
  end
end
