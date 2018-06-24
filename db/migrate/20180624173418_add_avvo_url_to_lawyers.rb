class AddAvvoUrlToLawyers < ActiveRecord::Migration[5.0]
  def change
    add_column :lawyers, :avvo_url, :string
  end
end
