class RemoveColumnWebsiteIdUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :website_id
  end
end
