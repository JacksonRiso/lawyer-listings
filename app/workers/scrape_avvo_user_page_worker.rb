# ScrapeAvvoLocationListWorker.perform_async("https://www.avvo.com/attorneys/35901-al-bradley-cornett-1953824.html")

require 'rubygems'
require 'nokogiri'
require 'open-uri'

class ScrapeAvvoUserPageWorker
  include Sidekiq::Worker

  def perform(url)
    url = 'https://www.avvo.com/attorneys/35901-al-bradley-cornett-1953824.html'
    page = Nokogiri::HTML(open(url, 'User-Agent' => 'firefox'))

    name = page.css('.v-lawyer-card').css('h1').text
    phone_number = page.css('.overridable-lawyer-phone-copy').text
    website = page.css('.js-address-container').css('.u-margin-bottom-0')[0]['content']
    address = page.css('.v-lawyer-address').css('p')[0].text
    avvo_rating = page.css('.v-lawyer-card').css('.h3').text.to_i
    number_of_avvo_legal_answers = page.css('.contribution-section').css('tr')[0].css('td')[1].text.to_i
    number_of_avvo_legal_guides = page.css('.contribution-section').css('tr')[1].css('td')[1].text.to_i
    number_of_avvo_reviews = page.css("[itemprop='reviewCount']")[0]['content']
    number_of_years_licensed = TimeDifference.between(page.css('.v-lawyer-card').css('time')[0]['datetime'], Time.now).in_years.to_i

    ##$$$$TO DO
      # puts offers_free_consultation = page.css().text ##boolean
      # puts is_avvo_pro = page.css().text ##boolean
      # puts profile_has_been_claimed = page.css.text() ##boolean
      # puts avvo_stars = page.css('.v-lawyer-card').css('.u-font-size-large')[0]["content"]

    # #ADD TO DATABASE
    Url.find_by(url: url).update(last_crawled: Time.now, name: name,
      phone_number: phone_number, website: website, address: address, avvo_rating: avvo_rating,
      number_of_avvo_legal_answers: number_of_avvo_legal_answers,
      number_of_avvo_legal_guides: number_of_avvo_legal_guides,
      number_of_avvo_reviews: number_of_avvo_reviews,
      number_of_years_licensed: number_of_years_licensed)

  end
end
