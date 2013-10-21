class ChangeColumnParentIdUsers < ActiveRecord::Migration
  def change
  	remove_column :users,:parent_id
  	add_column :users,:website_id,:integer,default: 0
  end
end
