class PublicController < ApplicationController
  def index
    # #Lawyers
    @number_of_lawyers = Lawyer.all.count
    @lawyers_created_by_day = Lawyer.where('created_at >= ?', 1.week.ago).group("DATE_TRUNC('date', created_at)").count
    @number_of_urls = Url.all.count
    @number_of_stocks = Stock.all.count
    @number_of_prices = Price.all.count
  end
end
