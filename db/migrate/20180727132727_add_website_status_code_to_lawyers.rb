class AddWebsiteStatusCodeToLawyers < ActiveRecord::Migration[5.0]
  def change
    add_column :lawyers, :website_status_code, :string
  end
end
