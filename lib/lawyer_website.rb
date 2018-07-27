require 'rubygems'
require 'nokogiri'
require 'open-uri'

module LawyerWebsite
  def self.open(url, lawyer_id)
    puts 'URL GOES HERE'
    puts url
    puts 'URL GOES HERE END'
    Nokogiri::HTML(open(url, 'User-Agent' => 'firefox'))
  rescue OpenURI::HTTPError => error
    Lawyer.find_by(id: lawyer_id).update(website_status_code: error.status)
  end
end
