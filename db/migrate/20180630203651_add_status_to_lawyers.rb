class AddStatusToLawyers < ActiveRecord::Migration[5.0]
  def change
    add_column :lawyers, :status, :string
  end
end
