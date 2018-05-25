class Url < ActiveRecord::Base
	validates :url, uniqueness: true
end
