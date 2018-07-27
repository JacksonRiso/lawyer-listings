class ContactMethod < ApplicationRecord
  def self.add_contact_method(contact_method_type, contact_method_info, lawyer_id)
    if email && !ContactMethod.find_by(info: contact_method_info)
      ContactMethod.create(lawyer_id: lawyer_id, contact_method_type: contact_method_type, info: contact_method_info)
    end
  end
end
