class Price < ActiveRecord::Base
  validates :unique_identifier, presence: true, uniqueness: true
end
