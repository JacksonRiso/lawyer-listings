class Lawyer < ActiveRecord::Base
  validates :avvo_url, uniqueness: true
  has_many :interactions
  has_many :contact_methods
end
