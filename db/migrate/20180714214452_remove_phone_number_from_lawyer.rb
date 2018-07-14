class RemovePhoneNumberFromLawyer < ActiveRecord::Migration[5.0]
  def change
    remove_column :lawyers, :phone_number
  end
end
