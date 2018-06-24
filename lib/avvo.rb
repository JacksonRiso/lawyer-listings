module Avvo
  def self.open_avvo_url
    Nokogiri::HTML(open(url, 'User-Agent' => 'firefox'))
  rescue OpenURI::HTTPError => error
    REDIS.set('avvo_scraper_last_error', Time.now)
    nil
  end
end
