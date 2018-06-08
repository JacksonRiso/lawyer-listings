class Stock < ActiveRecord::Base
  validates :symbol, uniqueness: true
end
