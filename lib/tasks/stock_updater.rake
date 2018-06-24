Price.where(unique_identifier: nil).limit(100_000).each do |price|
  unique_identifier = price.symbol + '-' + price.price_type + '-' + price.datetime.to_s
  price.update(unique_identifier: unique_identifier)
end
Price.where(unique_identifier: nil).count
