class Stock < ActiveRecord::Base
  validates :symbol, presence: true, uniqueness: true, length: { minimum: 2, maximum: 5 }, allow_blank: false
end
