# ScrapeAvvoUserPageWorker.perform_async(Url.last.url)

require 'rubygems'
require 'nokogiri'
require 'open-uri'

class ScrapeAvvoUserPageWorker
  include Sidekiq::Worker
  sidekiq_options queue: :avvo, retry: false, backtrace: false

  def perform(url)
    page = Avvo.open_avvo_url(url)
    unless page.nil?

      name = page.css('.v-lawyer-card').css('h1').text
      phone_number = page.css('.overridable-lawyer-phone-copy').first ? page.css('.overridable-lawyer-phone-copy').first.text.strip : nil
      website = page.css('.js-address-container').css('.u-margin-bottom-0')[0] ? page.css('.js-address-container').css('.u-margin-bottom-0')[0]['content'] : nil
      address = page.css('.v-lawyer-address').css('p')[0] ? page.css('.v-lawyer-address').css('p')[0].text : nil
      avvo_rating = page.css('.v-lawyer-card').css('.h3').text.to_i
      number_of_avvo_legal_answers = page.css('.contribution-section').css('tr')[0] ? page.css('.contribution-section').css('tr')[0].css('td')[1].text.to_i : nil
      number_of_avvo_legal_guides = page.css('.contribution-section').css('tr')[1] ? page.css('.contribution-section').css('tr')[1].css('td')[1].text.to_i : nil
      number_of_avvo_reviews = page.css("[itemprop='reviewCount']")[0] ? page.css("[itemprop='reviewCount']")[0]['content'] : 0
      number_of_years_licensed = page.css('.v-lawyer-card').css('time') && page.css('.v-lawyer-card').css('time')[0] ? TimeDifference.between(page.css('.v-lawyer-card').css('time')[0]['datetime'], Time.now).in_years.to_i : nil
      facebook = page.css('#contact').css('a[href*="facebook.com"]')[0] ? page.css('#contact').css('a[href*="facebook.com"]')[0]['href'] : nil
      twitter = page.css('#contact').css('a[href*="twitter.com"]')[0] ? page.css('#contact').css('a[href*="twitter.com"]')[0]['href'] : nil
      linkedin = page.css('#contact').css('a[href*="linkedin.com"]')[0] ? page.css('#contact').css('a[href*="linkedin.com"]')[0]['href'] : nil

      # #$$$$TO DO
      # puts offers_free_consultation = page.css().text ##boolean
      # puts is_avvo_pro = page.css().text ##boolean
      # puts profile_has_been_claimed = page.css.text() ##boolean
      # puts avvo_stars = page.css('.v-lawyer-card').css('.u-font-size-large')[0]["content"]

      # ADD TO DATABASE
      unless Lawyer.find_by(avvo_url: url)
        Lawyer.create(avvo_url: url, name: name, website: website,
                      address: address, avvo_rating: avvo_rating,
                      number_of_avvo_legal_answers: number_of_avvo_legal_answers,
                      number_of_avvo_legal_guides: number_of_avvo_legal_guides,
                      number_of_avvo_reviews: number_of_avvo_reviews,
                      number_of_years_licensed: number_of_years_licensed)
      end

      lawyer_id = Lawyer.find_by(avvo_url: url).id

      unless phone_number.nil? || ContactMethod.find_by(info: phone_number)
        ContactMethod.create(lawyer_id: lawyer_id, contact_method_type: 'phone_number', info: phone_number)
      end

      unless facebook.nil? || ContactMethod.find_by(info: facebook)
        ContactMethod.create(lawyer_id: lawyer_id, contact_method_type: 'facebook', info: facebook)
      end

      unless twitter.nil? || ContactMethod.find_by(info: twitter)
        ContactMethod.create(lawyer_id: lawyer_id, contact_method_type: 'twitter', info: twitter)
      end

      unless linkedin.nil? || ContactMethod.find_by(info: linkedin)
        ContactMethod.create(lawyer_id: lawyer_id, contact_method_type: 'linkedin', info: linkedin)
      end

      # Update URL
      Url.find_by(url: url).update(last_crawled: Time.now)
    end
  end
end
