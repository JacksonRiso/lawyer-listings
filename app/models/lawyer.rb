class Lawyer < ActiveRecord::Base
  validates :avvo_url, uniqueness: true
  has_many :specialties
end
