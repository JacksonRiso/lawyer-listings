class CreateInteractions < ActiveRecord::Migration[5.0]
  def change
    create_table :interactions do |t|
      t.integer :lawyer_id
      t.datetime :time_of_interaction
      t.integer :contact_method_id
      t.string :notes
      t.timestamps null: false
    end
  end
end
