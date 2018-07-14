class ChangeTypeOnContactMethods < ActiveRecord::Migration[5.0]
  def change
    rename_column :contact_methods, :type, :contact_method_type
  end
end
