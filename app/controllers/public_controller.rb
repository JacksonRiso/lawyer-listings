class PublicController < ApplicationController
  def index
    @number_of_lawyers = Lawyer.all.count
    @number_of_urls = Url.all.count
    @number_of_stocks = Stock.all.count
    @number_of_prices = Price.all.count
  end
end
