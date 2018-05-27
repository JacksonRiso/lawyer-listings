#ScrapeAvvoLocationListWorker.perform_async("https://www.avvo.com/find-a-lawyer")

require 'rubygems'
require 'nokogiri'
require 'open-uri'

class ScrapeAvvoLocationListWorker
  include Sidekiq::Worker

  def perform(url)
    #url = "https://www.avvo.com/find-a-lawyer"
    page = Nokogiri::HTML(open(url, 'User-Agent' => 'firefox'))
    page.css('#js-top-state-link-farm').css("ol.unstyled-list").css("li").each do |state|
    	link = "https://avvo.com" + state.css("a")[0]["href"]
      unless Url.find_by(url: link)
        Url.create(url: link, url_type: "location", domain: "avvo")
      end

      ##Update the current url
      Url.find_by(url: url).update(last_crawled: Time.now())

    end
  end
end
