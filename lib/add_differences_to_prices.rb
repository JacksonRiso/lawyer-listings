while Price.where('percent_difference_between_open_and_close IS NULL').count > 0
end
