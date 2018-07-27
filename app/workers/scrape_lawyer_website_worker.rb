require 'rubygems'
require 'nokogiri'
require 'open-uri'

class ScrapeLawyerWebsiteWorker
  include Sidekiq::Worker
  sidekiq_options queue: :lawyer_website, retry: false, backtrace: false

  def perform(url, lawyer_id)
    url = "http://#{url}" unless url[/\Ahttp:\/\//] || url[/\Ahttps:\/\//]

    page = begin
      Nokogiri::HTML(open(url,
                          'User-Agent' => 'firefox'))
    rescue OpenURI::HTTPError => error
      response = error.io
      Lawyer.find_by(id: lawyer_id).update(website_status_code: response.status)
      return nil
    end

    unless page.nil?
      email = page.css('a[href*="mailto"]')[0] ? page.css('a[href*="mailto"]')[0]['href'].gsub('mailto:', '') : nil
      facebook = page.css('a[href*="facebook.com"]')[0] ? page.css('a[href*="facebook.com"]')[0]['href'] : nil
      twitter = page.css('a[href*="twitter.com"]')[0] ? page.css('a[href*="twitter.com"]')[0]['href'] : nil
      linkedin = page.css('a[href*="linkedin.com"]')[0] ? page.css('a[href*="linkedin.com"]')[0]['href'] : nil

      unless email || ContactMethod.find_by(info: email)
        ContactMethod.create(lawyer_id: lawyer_id, contact_method_type: 'email', info: email)
      end

      unless facebook || ContactMethod.find_by(info: facebook)
        ContactMethod.create(lawyer_id: lawyer_id, contact_method_type: 'facebook', info: facebook)
      end

      unless twitter || ContactMethod.find_by(info: twitter)
        ContactMethod.create(lawyer_id: lawyer_id, contact_method_type: 'twitter', info: twitter)
      end

      unless linkedin || ContactMethod.find_by(info: linkedin)
        ContactMethod.create(lawyer_id: lawyer_id, contact_method_type: 'linkedin', info: linkedin)
      end

      Lawyer.find_by(id: lawyer_id).update(website_crawled: Time.now)
    end
  end
end
