class PublicController < ApplicationController
  def index
    # Lawyers
    @number_of_lawyers = Lawyer.all.count
    @lawyers_created_by_day = Lawyer.where('created_at >= ?', 1.week.ago).group("DATE_TRUNC('day', created_at)").order("DATE_TRUNC('day', created_at)").count

    # Contact Methods
    @number_of_phone_numbers = ContactMethod.where(contact_method_type: 'phone_number').count
    @number_of_email_addresses = ContactMethod.where(contact_method_type: 'email').count
    @number_of_facebooks = ContactMethod.where(contact_method_type: 'facebook').count
    @number_of_twitters = ContactMethod.where(contact_method_type: 'twitter').count
    @number_of_linkedins = ContactMethod.where(contact_method_type: 'twitter').count

    # Urls
    @number_of_urls = Url.all.count
    @number_of_crawled_urls = Url.where(domain: 'avvo').not.where(last_crawled: nil).count
    @number_of_uncrawled_urls = Url.where(last_crawled: nil, domain: 'avvo').count

    @urls_created_by_day = Url.where('created_at >= ?', 1.week.ago).group("DATE_TRUNC('day', created_at)").order("DATE_TRUNC('day', created_at)").count

    # Stocks
    @number_of_stocks = Stock.all.count
    @stocks_created_by_day = Stock.where('created_at >= ?', 1.week.ago).group("DATE_TRUNC('day', created_at)").order("DATE_TRUNC('day', created_at)").count

    # Prices
    @number_of_prices = Price.all.count
    @prices_created_by_day = Price.where('created_at >= ?', 1.week.ago).group("DATE_TRUNC('day', created_at)").order("DATE_TRUNC('day', created_at)").count
  end
end
