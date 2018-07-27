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

      ContactMethod.add_contact_method('email', email, lawyer_id)
      ContactMethod.add_contact_method('facebook', facebook, lawyer_id)
      ContactMethod.add_contact_method('twitter', twitter, lawyer_id)
      ContactMethod.add_contact_method('linkedin', linkedin, lawyer_id)
      Lawyer.find_by(id: lawyer_id).update(website_crawled: Time.now)

    end
  end
end
