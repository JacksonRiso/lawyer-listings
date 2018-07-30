class Price < ActiveRecord::Base
  validates :symbol, uniqueness: { scope: %i[datetime price_type] }
  validates :open, :close, :low, :high, presence: true, numericality: { other_than: 0 }
  before_create :create_differences
  def create_differences
    self.percent_difference_between_open_and_close = ((close - open) / open) * 100
    self.percent_difference_between_low_and_high = ((high - low) / low) * 100
  end
end
