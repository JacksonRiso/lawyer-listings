# ScrapeAvvoLocationSpecialtyListWorker.perform_async("https://avvo.com/all-lawyers/al.html")

require 'rubygems'
require 'nokogiri'
require 'open-uri'

class ScrapeAvvoLocationSpecialtyListWorker
  include Sidekiq::Worker
  sidekiq_options queue: :avvo, retry: false, backtrace: false

  def perform(url)
    page = Nokogiri::HTML(open(url, 'User-Agent' => 'firefox'))
    page.css('.pa-list').css('a').each do |specialty|
      link = 'https://avvo.com' + specialty['href']
      unless Url.find_by(url: link)
        Url.create(url: link, url_type: 'location_specialty', domain: 'avvo')
      end

      # #Update the current url
      Url.find_by(url: url).update(last_crawled: Time.now)
    end
  end
end
