class LawyersSpecialties < ActiveRecord::Migration
  def change
		create_join_table :lawyers, :specialties do |t|
  		t.index :lawyer_id
  		t.index :specialty_id
  		t.integer :percent_of_business_is_this_specialty
  		t.integer :number_of_years_working_in_this_specialty
		end
  end
end
