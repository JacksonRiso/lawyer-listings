Price.where('percent_difference_between_open_and_close IS NULL').count
while Price.where('percent_difference_between_open_and_close IS NULL').limit(100_000).each do |price|
  percent_difference_between_open_and_close = ((price.open - price.close) / price.open) * 100
  percent_difference_between_low_and_high = ((price.low - price.high) / price.high) * 100
  Price.find_by(id: price.id).update(percent_difference_between_open_and_close: percent_difference_between_open_and_close.to_d.truncate(2),
                                     percent_difference_between_low_and_high: percent_difference_between_low_and_high.to_d.truncate(2))
end
