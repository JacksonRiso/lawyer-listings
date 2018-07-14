class PublicController < ApplicationController
  def index
    # Lawyers
    @number_of_lawyers = Lawyer.all.count
    @lawyers_created_by_day = Lawyer.where('created_at >= ?', 1.week.ago).group("DATE_TRUNC('day', created_at)").order(:created_at).count

    # Urls
    @number_of_urls = Url.all.count
    @urls_created_by_day = Url.where('created_at >= ?', 1.week.ago).group("DATE_TRUNC('day', created_at)").order(:created_at).count

    # Stocks
    @number_of_stocks = Stock.all.count
    @stocks_created_by_day = Stock.where('created_at >= ?', 1.week.ago).group("DATE_TRUNC('day', created_at)").order(:created_at).count

    # Prices
    @number_of_prices = Price.all.count
    @prices_created_by_day = Price.where('created_at >= ?', 1.week.ago).group("DATE_TRUNC('day', created_at)").order(:created_at).count
  end
end
