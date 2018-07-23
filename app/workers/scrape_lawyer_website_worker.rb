require 'rubygems'
require 'nokogiri'
require 'open-uri'

class ScrapeLawyerWebsiteWorker
  include Sidekiq::Worker
  sidekiq_options queue: :lawyer_website, retry: false, backtrace: false

  def perform(url, lawyer_id)
    url = 'https://plattner-verderame.com/attorneys/frank-verderame/'
    page = Nokogiri::HTML(open(url, 'User-Agent' => 'firefox'))
    unless page.nil?
      email = page.css('a[href*="mailto"]')[0] ? page.css('a[href*="mailto"]')[0]['href'].gsub('mailto:', '') : nil
      facebook = page.css('a[href*="facebook.com"]')[0] ? page.css('a[href*="facebook.com"]')[0]['href'] : nil
      twitter = page.css('a[href*="twitter.com"]')[0] ? page.css('a[href*="twitter.com"]')[0]['href'] : nil
      linkedin = page.css('a[href*="linkedin.com"]')[0] ? page.css('a[href*="linkedin.com"]')[0]['href'] : nil

      unless email && ContactMethod.find_by(info: email)
        ContactMethod.create(lawyer_id: lawyer_id, contact_method_type: 'email', info: email)
      end

      unless facebook && ContactMethod.find_by(info: facebook)
        ContactMethod.create(lawyer_id: lawyer_id, contact_method_type: 'facebook', info: facebook)
      end

      unless twitter_link && ContactMethod.find_by(info: twitter)
        ContactMethod.create(lawyer_id: lawyer_id, contact_method_type: 'twitter', info: twitter)
      end

      unless linkedin_link && ContactMethod.find_by(info: linkedin)
        ContactMethod.create(lawyer_id: lawyer_id, contact_method_type: 'linkedin', info: linkedin)
      end
    end
  end
end
