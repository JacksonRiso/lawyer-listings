class Price < ActiveRecord::Base
  validates :unique_identifier, presence: true, uniqueness: true
  validates :open, :close, :low, :high, numericality: { other_than: 0 }
  before_create :create_differences
  def create_differences
    self.percent_difference_between_open_and_close = ((open - close) / open) * 100
    self.percent_difference_between_low_and_high = ((low - high) / high) * 100
  end
end
