class RemoveEmailFromLawyers < ActiveRecord::Migration[5.0]
  def change
    remove_column :lawyers, :email_address
  end
end
