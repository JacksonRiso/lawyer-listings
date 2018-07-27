require 'rubygems'
require 'nokogiri'
require 'open-uri'

module LawyerWebsite
  def self.open(url, lawyer_id)
    Nokogiri::HTML(open(url, 'User-Agent' => 'firefox'))
  rescue OpenURI::HTTPError => error
    Lawyer.find_by(id: lawyer_id).update(website_status_code: error.status)
  end
end
