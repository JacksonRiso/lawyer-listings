class LawyersSpecialties < ActiveRecord::Migration
  def change
  	create_table :assignments_security_users, :id => true do |t|
      t.integer :lawyer_id
      t.integer :specialty_id
      t.integer :percent_for_this_specialty
      t.integer :number_of_years_of_experience_for_this_specialty
    end
  end
end
