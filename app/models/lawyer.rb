class Lawyer < ActiveRecord::Base
	has_many :urls
	has_many :specialties
end
