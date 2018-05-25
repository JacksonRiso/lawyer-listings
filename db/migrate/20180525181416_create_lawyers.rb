class CreateLawyers < ActiveRecord::Migration
  def change
    create_table :lawyers do |t|
    	t.string :name
    	t.string :phone_number
    	t.string :website
    	t.string :address
    	t.integer :avvo_rating
      t.boolean :is_avvo_pro
      t.integer :number_of_avvo_legal_answers
      t.integer :number_of_avvo_legal_guides
      t.integer :number_of_avvo_reviews
      t.integer :number_of_years_licensed
      t.boolean :offers_free_consultation
      t.string :email_address
      t.timestamps null: false
    end
  end
end
