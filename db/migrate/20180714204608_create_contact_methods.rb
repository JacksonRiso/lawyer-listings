class CreateContactMethods < ActiveRecord::Migration[5.0]
  def change
    create_table :contact_methods do |t|
      t.integer :lawyer_id
      t.string :type
      t.string :info
      t.string :status
      t.timestamps
    end
  end
end
