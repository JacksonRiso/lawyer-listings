class Interaction < ApplicationRecord
  has_one :lawyer
  has_one :contact_method
end
